#!/bin/bash

# Five minute plan for centos, DNS box 
# Made for IRSEC, by choi 
#
#

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

iptables -F
chattr -i /etc/shadow
chattr -i /etc/sudoers
chattr -i /etc/ssh/sshd_config
chattr -R -a /var/log

bash init.sh
bash backup.sh
bash secure.sh
bash iptables.sh
printf "\nEnabling my iptables ........ DONE\n"

chattr +i /etc/shadow
chattr +i /etc/sudoers
chattr +i /etc/ssh/sshd_config
chattr -R +a /var/log

printf "\nRemember /dev/string/bin/linenum.sh !\n"
printf "\nRestart sshd and named/powerdns when you are done !!! \n"
#/dev/string/bin/linenum.sh & > 

printf "\nFive minute plan have finished.\n"
