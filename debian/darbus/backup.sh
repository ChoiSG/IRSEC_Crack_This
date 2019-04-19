#!/bin/bash

backupWEB() { 
    # if nginx --> Check for headshot. Follow the headshot plan.
    if [ -n "$(command -v nginx)" ]; then 
        hs=`nginx -V 2>&1`
        tar -czvf "./nginx_backup.tar.gz" /etc/nginx/ /usr/share/nginx/ /usr/lib/nginx/

    elif [ -n "$(command -v apache2)" ]; then 
        tar -czvf "./apache2_backup.tar.gz" /etc/apache2/ /var/www/html/
    fi
}

backupBIN() {
    cd /dev/string/bin
    cp /usr/bin/apt .
    cp /usr/bin/apt-get .
    wget https://busybox.net/downloads/binaries/1.30.0-i686/busybox 
    cd ..
}

grabCONFs(){
    cd /dev/string/old_conf
    cp ~/.profile ~/.bashrc ~/.vimrc ~/.bash_profile /etc/ssh/sshd_config /etc/sudoers /etc/pam.d/common-auth ~/.bash_history ~/.ssh/* ~/.lesshst .
    
    for $filez in *; do 
        mv $filez $filez.old
    done

    cd /dev/string
}

backupWEB
backupBIN
grabCONFs
