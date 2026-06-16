#!/bin/bash
# Configuration de l'isolation réseau pour l'OlixSense IMU

IMU_IFACE="enx_olive_imu"
ACTUAL_USER=${SUDO_USER:-$USER}

echo "[INFO] Nettoyage de l'ancienne session..."
# Tuer le bon script Python
sudo pkill -f imu_relay.py 2>/dev/null
# Ramener de force l'interface dans le namespace hôte (PID 1) avant destruction
sudo ip netns exec imu_ns ip link set $IMU_IFACE netns 1 2>/dev/null
sudo ip netns del imu_ns 2>/dev/null
sudo ip link del veth_main 2>/dev/null
# 1. [CRITIQUE] Forcer udev à réévaluer les interfaces réseau
sudo udevadm trigger --action=add --subsystem-match=net
sudo udevadm settle

# 2. Attente active de l'interface (Polling jusqu'à 15 secondes)
echo "[INFO] Attente du retour de l'interface $IMU_IFACE sur l'hôte..."
MAX_RETRIES=15
COUNT=0
while ! ip link show $IMU_IFACE > /dev/null 2>&1; do
    sleep 1
    COUNT=$((COUNT+1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "[ERREUR] L'interface $IMU_IFACE est introuvable après ${MAX_RETRIES}s. Débranche et rebranche l'IMU."
        exit 1
    fi
done
echo "[OK] Interface $IMU_IFACE trouvée."

# 3. [CRITIQUE] Empêcher NetworkManager d'interférer avec cette interface
sudo nmcli dev set $IMU_IFACE managed no 2>/dev/null

echo "[INFO] Création du namespace et migration..."
sudo ip netns add imu_ns
sudo ip netns exec imu_ns ip link set dev lo up
sudo ip link set $IMU_IFACE netns imu_ns

# 4. Configuration IP dans le Namespace
sudo ip netns exec imu_ns ip addr add 192.168.7.102/24 brd 192.168.7.255 dev $IMU_IFACE
sudo ip netns exec imu_ns ip link set $IMU_IFACE up

# 5. Création du tunnel veth
sudo ip link add veth_main type veth peer name veth_ns
sudo ip link set veth_ns netns imu_ns

# 6. Configuration du tunnel (Hôte)
sudo ip addr add 10.0.0.1/24 dev veth_main
sudo ip link set veth_main up
sudo ip route add 224.0.0.0/4 dev veth_main 2>/dev/null

# 7. Configuration du tunnel (Namespace)
sudo ip netns exec imu_ns ip addr add 10.0.0.2/24 dev veth_ns
sudo ip netns exec imu_ns ip link set veth_ns up
sudo ip netns exec imu_ns ip route add 224.0.0.0/4 dev veth_ns 2>/dev/null

# 7. Configuration des buffers (Namespace) alignée avec l'hôte
sudo ip netns exec imu_ns sysctl -w net.core.rmem_max=8388608
sudo ip netns exec imu_ns sysctl -w net.core.rmem_default=8388608
sudo ip netns exec imu_ns sysctl -w net.core.wmem_max=8388608
sudo ip netns exec imu_ns sysctl -w net.core.wmem_default=8388608

echo "[INFO] Démarrage du pont ROS 2 (topic_tools) dans l'espace isolé..."

nohup sudo ip netns exec imu_ns sudo -u $ACTUAL_USER bash -c "
  export HOME=/home/$ACTUAL_USER
  export ROS_LOG_DIR=/tmp/ros_logs_$ACTUAL_USER
  source /opt/ros/humble/setup.bash
  source /home/$ACTUAL_USER/sensor_platform_ws/install/setup.bash
  export ROS_DOMAIN_ID=0
  export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
  
  # ---> CORRECTION 2 : Charger le profil DDS optimisé pour le relais
  export FASTRTPS_DEFAULT_PROFILES_FILE=/home/$ACTUAL_USER/sensor_platform_ws/src/olive_networking/config/fastdds_profiles.xml
  
  python3 /home/$ACTUAL_USER/sensor_platform_ws/src/olive_networking/scripts/imu_relay.py &
" > /tmp/imu_relay.log 2>&1 &

echo "[OK] Relais ROS 2 actif. Les topics de l'IMU sont pontés sur le domaine 0."
