#!/bin/bash

############################################################
#           consts
############################################################

readonly KEYCODE_UNKNOWN=0
readonly KEYCODE_MENU=1
readonly KEYCODE_SOFT_RIGHT=2
readonly KEYCODE_HOME=3
readonly KEYCODE_BACK=4
readonly KEYCODE_CALL=5
readonly KEYCODE_ENDCALL=6
readonly KEYCODE_0=7
readonly KEYCODE_1=8
readonly KEYCODE_2=9
readonly KEYCODE_3=10
readonly KEYCODE_4=11
readonly KEYCODE_5=12
readonly KEYCODE_6=13
readonly KEYCODE_7=14
readonly KEYCODE_8=15
readonly KEYCODE_9=16
readonly KEYCODE_STAR=17
readonly KEYCODE_POUND=18
readonly KEYCODE_DPAD_UP=19
readonly KEYCODE_DPAD_DOWN=20
readonly KEYCODE_DPAD_LEFT=21
readonly KEYCODE_DPAD_RIGHT=22
readonly KEYCODE_DPAD_CENTER=23
readonly KEYCODE_VOLUME_UP=24
readonly KEYCODE_VOLUME_DOWN=25
readonly KEYCODE_POWER=26
readonly KEYCODE_CAMERA=27
readonly KEYCODE_CLEAR=28
readonly KEYCODE_A=29
readonly KEYCODE_B=30
readonly KEYCODE_C=31
readonly KEYCODE_D=32
readonly KEYCODE_E=33
readonly KEYCODE_F=34
readonly KEYCODE_G=35
readonly KEYCODE_H=36
readonly KEYCODE_I=37
readonly KEYCODE_J=38
readonly KEYCODE_K=39
readonly KEYCODE_L=40
readonly KEYCODE_M=41
readonly KEYCODE_N=42
readonly KEYCODE_O=43
readonly KEYCODE_P=44
readonly KEYCODE_Q=45
readonly KEYCODE_R=46
readonly KEYCODE_S=47
readonly KEYCODE_T=48
readonly KEYCODE_U=49
readonly KEYCODE_V=50
readonly KEYCODE_W=51
readonly KEYCODE_X=52
readonly KEYCODE_Y=53
readonly KEYCODE_Z=54
readonly KEYCODE_COMMA=55
readonly KEYCODE_PERIOD=56
readonly KEYCODE_ALT_LEFT=57
readonly KEYCODE_ALT_RIGHT=58
readonly KEYCODE_SHIFT_LEFT=59
readonly KEYCODE_SHIFT_RIGHT=60
readonly KEYCODE_TAB=61
readonly KEYCODE_SPACE=62
readonly KEYCODE_SYM=63
readonly KEYCODE_EXPLORER=64
readonly KEYCODE_ENVELOPE=65
readonly KEYCODE_ENTER=66
readonly KEYCODE_DEL=67
readonly KEYCODE_GRAVE=68
readonly KEYCODE_MINUS=69
readonly KEYCODE_EQUALS=70
readonly KEYCODE_LEFT_BRACKET=71
readonly KEYCODE_RIGHT_BRACKET=72
readonly KEYCODE_BACKSLASH=73
readonly KEYCODE_SEMICOLON=74
readonly KEYCODE_APOSTROPHE=75
readonly KEYCODE_SLASH=76
readonly KEYCODE_AT=77
readonly KEYCODE_NUM=78
readonly KEYCODE_HEADSETHOOK=79
readonly KEYCODE_FOCUS=80
readonly KEYCODE_PLUS=81
readonly KEYCODE_MENU_2=82
readonly KEYCODE_NOTIFICATION=83
readonly KEYCODE_SEARCH=84
readonly TAG_LAST_KEYCODE=85


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
   echo "--------- -h                           Help"
   echo "--------- -list                        List all devices"
   echo "--------- -lock                        Lock the screen"
   echo "--------- -unlock                      Unlock the screen"
   echo "--------- -wifion                      Enable Wifi"
   echo "--------- -wifioff                     Disable Wifi"
   echo "--------- -cat_file                    Show file content [package] [file]"
   echo "--------- -screenrecord [file]         Record screen to file [file] on Movies folder"
   echo "--------- -pullrecord [file] [path]    Record record screen [file] to [path]"
   
   echo "--------- -reboot                      Reboot device"
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
    execute_command "shell input keyevent $KEYCODE_POWER"
fi

if  [[ $operation = "-unlock" ]]; then
############################################################
#           command unlock screen
############################################################

    echo "--------- Unlock screen"
    execute_command "shell input keyevent $KEYCODE_MENU_2"
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

if  [[ $operation = "-cat_file" ]]; then
############################################################
#           command show file content
############################################################

    echo "--------- Show file content $3 of $2"
    execute_command "shell run-as $2 cat $3"
fi

if  [[ $operation = "-screenrecord" ]]; then
############################################################
#           command record screen
############################################################

    echo "--------- Record screen to file $2"
    execute_command "shell screenrecord /storage/self/primary/Movies/$2.mp4"
fi

if  [[ $operation = "-pullrecord" ]]; then
############################################################
#           command pull the record screen file
############################################################

    echo "--------- Pull the record file $2 to $3"
    execute_command "pull /storage/self/primary/Movies/$2.mp4 $3"
fi

