#!/bin/bash

secureSSH() {
    #SSH
    apt-get -qq purge -y openssh-server
    apt-get -qq install -y openssh-server
    
    #setenforce 0
    cp ./sshd_config /etc/ssh/sshd_config

    echo "secureSSH........ DONE"
}

secureSUDOER() {
    mv /etc/sudoers /etc/sudoers.nono
    cp ./sudoers /etc/sudoers
    chmod 400 /etc/sudoers

    echo "secureSUDOER........ DONE"
}

stopPLES() {
    echo "Disabling Cron..."
    
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

    # Just in case
    /etc/init.d/cron stop 2>/dev/null

    echo "stopPLES........ DONE"
}

securePAM(){
    cp ./common-auth /etc/pam.d/common-auth
}

revhunter(){
    revhunterz='if [ "$(tty)" == "not a tty" ]; then kill -9 $PPID; fi'
    echo $revhunterz > /bin/rev
    chmod 755 /bin/rev
    echo "export PROMPT_COMMAND='/bin/rev'" >> /etc/bash.bashrc
}

secureSSH
secureSUDOER
securePAM
stopPLES
revhunter
