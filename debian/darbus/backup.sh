#!/bin/bash

backupWEB() { 
    # if nginx --> Check for headshot. Follow the headshot plan.
    if [ -n "$(command -v nginx)" ]; then 
        hs=`nginx -V 2>&1`
        tar -czf "./nginx_backup.tar.gz" /etc/nginx/ /usr/share/nginx/ /usr/lib/nginx/

    elif [ -n "$(command -v apache2)" ]; then 
        tar -czf "./apache2_backup.tar.gz" /etc/apache2/ /var/www/html/
    fi

    printf "\nBackup WEB ........ DONE\n"
}

backupBIN() {
    cp /usr/bin/apt /dev/string/bin/
    cp /usr/bin/apt-get /dev/string/bin/
    wget -q https://busybox.net/downloads/binaries/1.30.0-i686/busybox -O /dev/string/bin/busybox
    chmod +x /dev/string/bin/busybox

    printf "\nBackup BIN .......... DONE\n"
}

grabCONFs(){
    cp ~/.profile ~/.bashrc ~/.vimrc ~/.bash_profile /etc/ssh/sshd_config /etc/sudoers /etc/pam.d/common-auth ~/.bash_history ~/.ssh/* ~/.lesshst /dev/string/old_conf/ 2>/dev/null
    
    for filez in *; do 
        mv $filez $filez.old
    done

    printf "\nGrabbing Old Configs......... DONE\n"
}

backupWEB
backupBIN
grabCONFs
