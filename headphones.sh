#!/usr/bin/env bash

# Name from bluetooth devices list
headphones=$"WH-CH700N"

# Run bluetooth paired-devices to get device ID#
devices="$(bluetoothctl paired-devices)"
# split string on space and store as array of strings
devs=($devices) 
#array_len=${#devs[@]}

# Vars to store array index
ind=-1
id_ind=''

# loop through array and look for name - ID will be previous entry
for i in ${!devs[@]};
do
	#echo "${devs[$i]}"
	if [[ ${devs[$i]} == $headphones ]]; then
		#echo "Element $i matched"
		id_ind=$i-1
		id=${devs[$id_ind]}
		echo "Found headphones with ID $id, turning off and on again..."
		pactl set-card-profile bluez_card.$id a2dp_sink
		bluetoothctl disconnect $id
		pactl set-card-profile bluez_card.$idE a2dp_sink
		bluetoothctl connect $id
		break
	fi
done

