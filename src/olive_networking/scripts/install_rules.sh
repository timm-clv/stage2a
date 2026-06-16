#!/bin/bash

echo "Déploiement des règles udev (Capteurs Olive) vers le système..."

# Copie du fichier du workspace vers le répertoire système
sudo cp $(dirname "$0")/../rules/99-olive-networking.rules /etc/udev/rules.d/

# Rechargement des règles udev
echo "Rechargement des règles udev..."
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=net

echo "Installation terminée avec succès."
