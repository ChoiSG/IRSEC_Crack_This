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

echo "Setting up Firewall...."
bash iptables.sh
echo "DONE"



printf "\nFive minute plan have finished.\n"

