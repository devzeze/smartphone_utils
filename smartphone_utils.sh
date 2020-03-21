#!/bin/bash


############################################################
#           function to call command
############################################################
execute_command() {

    adb_cmd="${adb_cmd} $1"
    echo ${adb_cmd}
    output=$(eval "$adb_cmd")
    echo "$output"
    exit 1
}

if [ ! "$1" ]; then
   echo "--------- Empty argument, please run"
fi

if [ ! "$1" ] || [[ $1 = "-h" ]]; then
   echo "--------- sh smartphone_utils.sh [-d [device_id]] with options:"
   echo "--------- -h                   Help"
   echo "--------- -list                List all devices"
   echo "--------- -lock                Lock the screen"
   echo "--------- -unlock              Unlock the screen"
   echo "--------- -wifion              Enable Wifi"
   echo "--------- -wifioff             Disable Wifi"
   echo "--------- -reboot              Reboot device"
   exit 1
fi

if ! [ -x "$(command -v adb)" ]; then
    echo "--------- Error: adb is not installed"
    exit 1
fi

adb_cmd="adb"
operation=$1

if  [[ $1 = "-d" ]]; then
############################################################
#           command list devices
############################################################
    adb_cmd="${adb_cmd} -s $2"
    operation=$3
fi


if  [[ $operation = "-list" ]]; then
############################################################
#           command list devices
############################################################

    echo "--------- Devices"
    adb devices -l
    exit 1
fi

if  [[ $operation = "-reboot" ]]; then
############################################################
#           command reboot device
############################################################

    echo "--------- Reboot"    
    execute_command "reboot"
fi

if  [[ $operation = "-lock" ]]; then
############################################################
#           command lock screen
############################################################

    echo "--------- Lock screen"
    execute_command "shell input keyevent 26"
fi

if  [[ $operation = "-unlock" ]]; then
############################################################
#           command unlock screen
############################################################

    echo "--------- Unlock screen"
    execute_command "shell input keyevent 82"
fi

if  [[ $operation = "-wifion" ]]; then
############################################################
#           command enable wifi
############################################################

    echo "--------- Enable wifi"
    execute_command "shell 'svc wifi enable'"
fi

if  [[ $operation = "-wifioff" ]]; then
############################################################
#           command disable wifi
############################################################

    echo "--------- Disable wifi"
    execute_command "shell 'svc wifi disable'"
fi