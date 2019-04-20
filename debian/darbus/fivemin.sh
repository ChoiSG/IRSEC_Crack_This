#!/bin/bash

# DEBUG MODE 
if [[ $1 == "debug" ]]; then 
    echo "Debug mode..."

    rm -rf /dev/string

    iptables -F
    echo "Flushing iptables........ DONE"
    exit
fi



clear 
echo "========================================="
echo "          Running 5 min Plan             "
echo "========================================="

chmod +x init.sh backup.sh secure.sh iptables.sh

bash init.sh
bash backup.sh
bash secure.sh
bash iptables.sh
printf "\nEnabling my iptables ........ DONE\n"

printf "\nRemember /dev/string/bin/linenum.sh !\n"
#/dev/string/bin/linenum.sh & > 

printf "\nFive minute plan have finished.\n"

