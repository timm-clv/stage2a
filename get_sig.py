#!/usr/bin/env python3
import dronecan

try:
    node = dronecan.make_node('slcan0', node_id=127, bitrate=1000000)
except Exception as e:
    print(f"Error opening the CAN port: {e}")
    exit(1)

print("Listening on the bus... (Lift the H-Flow sensor if necessary!)")

def intercept_message(event):
    msg_name = event.message._type.full_name
    
    if msg_name == "uavcan.equipment.range_sensor.Measurement": #com.hex.equipment.flow.Measurement ou uavcan.equipment.range_sensor.Measurement
        # We use the library method to calculate the exact 64-bit signature
        sig = event.message._type.get_data_type_signature()
        
        print("\n" + "="*60)
        print(f"🎯 BINGO ! LA SIGNATURE DSDL EST : {hex(sig)}ULL")
        print("="*60 + "\n")
        exit(0) 

# Subscribe to all posts
node.add_handler(None, intercept_message)

try:
    node.spin()
except KeyboardInterrupt:
    pass
    
    
    
    
 
