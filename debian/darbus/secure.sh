#!/bin/bash

secureSSH() {
    #SSH
    apt-get purge -y openssh-clients openssh-server
    apt-get install -y openssh-clients openssh-server
    
    #setenforce 0
    mv /etc/ssh/sshd_config ./fun/sshd_config_old.bak
    cp ./sshd_config /etc/ssh

    echo "secureSSH........ DONE"
}

secureSUDOER() {
    cp /etc/sudoers ./fun/sudoers_old.bak
    mv /etc/sudoers /etc/sudoers.nono
    cp ./sudoers /etc/
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
    /etc/init.d/cron stop

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
