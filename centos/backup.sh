#!/bin/bash

backupDNS() { 
    # if nginx --> Check for headshot. Follow the headshot plan.
    if [ -n "$(command -v named)" ]; then 
        tar -czf "/dev/string/named_bind.tar.gz" /etc/named.conf /var/named

    elif [ -n "$(command -v pdns_server)" ]; then 
        tar -czf "/dev/string/pdns_server.tar.gz" /etc/pdns/pdns.conf /var/named
    fi

    printf "\nBackup DNS ........ DONE\n"
}

backupBIN() {
    cp /usr/bin/yum /dev/string/bin/
    cp /usr/bin/yum /usr/bin/tlqkfyum
    wget -q https://busybox.net/downloads/binaries/1.30.0-i686/busybox -O /dev/string/bin/busybox
    chmod +x /dev/string/bin/busybox

    printf "\nBackup BIN .......... DONE\n"
}

grabCONFs(){
    cp ~/.profile ~/.bashrc ~/.vimrc ~/.bash_profile /etc/ssh/sshd_config /etc/sudoers /etc/pam.d/common-auth ~/.bash_history ~/.ssh/* ~/.lesshst /etc/pam.d/system-auth  /dev/string/old_conf/  2>/dev/null

        
    for filez in /dev/string/old_conf/*; do 
        mv $filez $filez.old
    done

    for filez in /dev/string/old_conf/.*; do
        mv $filez $filez.old
    done

    printf "\nGrabbing Old Configs......... DONE\n"
}

backupDNS
backupBIN
grabCONFs
