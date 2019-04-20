#!/bin/bash 

bash savestate.sh
bash pass.sh
bash backup.sh

if [ -n "$(command -v cron)" ]; then 
    cronname="cron"
else
    cronname="crond"
fi

if [ -n "$(command -v service)" ]; then
    service $cronname stop
    service anacron stop
    service atd stop
elif [ -n "$(command -v systemctl)" ]; then
    systemctl stop $cronname
    systemctl disable $cronname
    systemctl stop anacron
    systemctl disable anacron
    systemctl stop atd
    systemctl disable atd 
elif [ -n "$(command -v initctl)" ]; then
    initctl stop $cronname
    initctl stop anacron
    initctl stop atd
fi


if [[ $(which yum)]]; then 
    yum install curl wget git
elif [[ $(which apt-get)]]; then
    apt-get install curl htop git
elif [[ $(which pickle)]]; then
    pickle curl
    pickle wget
fi