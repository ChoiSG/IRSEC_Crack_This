#!/bin/bash

secureSSH() {
    cp `which sshd` /dev/string/bin/sshd.old
    #SSH
    yum -q remove -y openssh-server
    yum -q install -y openssh-server
    

    #setenforce 0
    cp ./sshd_config /etc/ssh/sshd_config
    chmod 400 /etc/ssh/sshd_config
    
    printf "\nsecureSSH........ DONE\n"
}

secureSUDOER() {
    mv /etc/sudoers /etc/sudoers.nono
    cp ./sudoers /etc/sudoers
    chmod 400 /etc/sudoers

    printf "\nsecureSUDOER........ DONE\n"
}

stopPLES() {
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

    echo "Disabling Cron........ DONE"
}

revhunter(){
    revhunterz='if [ "$(tty)" == "not a tty" ]; then kill -9 $PPID; fi'
    echo $revhunterz > /bin/rev
    chmod 755 /bin/rev
    echo "export PROMPT_COMMAND='/bin/rev'" >> /etc/bashrc
}

secureSSH
secureSUDOER
stopPLES
revhunter
printf "\nWatch out for /etc/pam.d/system-auth !!\n"
