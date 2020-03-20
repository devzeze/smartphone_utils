#!/bin/bash

if [ ! "$1" ]; then
   echo "--------- Empty argument, please run"
fi

if [ ! "$1" ] || [[ $1 = "-h" ]]; then
   echo "--------- sh smartphone_utils.sh with options:"
   echo "--------- -h                   Help"
   echo "--------- -lock                Lock the screen"
   echo "--------- -unlock              Unlock the screen"
   echo "--------- -reboot              Reboot device"
   exit 1

fi

if ! [ -x "$(command -v adb)" ]; then
    echo "--------- Error: adb is not installed"
    exit 1
fi


if  [[ $1 = "-reboot" ]]; then
############################################################
#           command reboot device
############################################################

    echo "--------- Reboot"
    adb reboot
    exit 1

fi

if  [[ $1 = "-lock" ]]; then
############################################################
#           command lock screen
############################################################

    echo "--------- Lock screen"
    adb shell input keyevent 26

fi

if  [[ $1 = "-unlock" ]]; then
############################################################
#           command unlock screen
############################################################

    echo "--------- Unlock screen"
    adb shell input keyevent 82

fi
