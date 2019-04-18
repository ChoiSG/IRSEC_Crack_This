#!/bin/sh

# [[ TODO ]] 
#   1. Ask about mail (25,110,143) ports and firewall rules 
#   2. chattr log stuffs 
#   3. Discuss with crack members and add more stuff 
#
# Stuart's vpn is a nono

# Script - TODO 
# 1. Change credentials (add sudo user?) 
# 2. Setup firewall 
# 3. Change sudoers + sshd_config 
# 4. Loot redteam's history 
#

setupBACKUPUSER() {
    useradd go
    echo "Wkwkdaus!" | passwd --stdin go
    usermod go -aG wheel go 
}


setupTERMINATOR() { 
    apt-get install -y terminator
    echo "setupTERMINATOR........ DONE" 

}


setupFIREWALL() {
    chmod +x iptables.sh
    bash iptables.sh
}

changePASS() {
    echo "Changing password for following users..." 
    echo `getUSERS`
    echo -n "type new password: "
    read passwd
    getUSERS | xargs -d'\n' -I {} sh -c "echo {}:$passwd | chpasswd"

    echo "changePass........ DONE"
}

getUSERS() {
    while IFS=: read a b c
    do
        if [ ! "$b" == "!" ] && [ ! "$b" == "*" ]; then 
            echo "$a"
        fi
    done < /etc/shadow
}

getUSERS2() {
    for i in $(cat /etc/shadow); do
        for j in $(echo $i | awk -F ':' '{
                    if ($2 != "*")
                        print $1
                }'); do
            echo "Change $j!"    #"$j:$NEWPASS" | chpasswd
        done
    done
}

redteamFUN() {
    mkdir "./fun"
    tar -czvf "./fun/initials.tar.gz" ~/.ssh ~/.profile ~/.bash_history ~/.bashrc ~/.lesshst
    #for i in $(ls /home); do
    #    tar -czf "./fun/initial.home.$i.tar.gz" /home/$i 
    #done

    echo "redteamFUN........ DONE"
}

secureSSH() {
    #SSH
    apt-get purge -y openssh-clients openssh-server
    apt-get install -y openssh-clients openssh-server
    
    setenforce 0
    mv /etc/ssh/sshd_config /etc/ssh/old_daemon_config
    cp ./sshd_config /etc/ssh

    echo "secureSSH........ DONE"
}

secureSUDOER() {
    cp /etc/sudoers ./fun/red_team_sudoers.bak
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

    echo "stopPLES........ DONE"
}

# Need to fix this 
#revhunter() {
#    cat revhunter > /bin/rev
#    chmod 755 /bin/rev
#    echo "export PROMPT_COMMAND='/bin/rev'" >> /etc/bash.bashrc
#}

# checkERROR



############# MAIN FUNC ##############

# DEBUG MODE 
if [ $1 == "debug" ]; then 
    echo "Debug mode..."

    rm -rf ./fun
    echo "Removing ./fun dir........ DONE"

    rm *.error
    echo "Removing all error files........ DONE"

    iptables -F
    echo "Flushing iptables........ DONE"
    exit
fi

# If not debug mode, fire away
iptables -F  
changePASS 2>>changePASS.error
setupBACKUPUSER 2>>setupBACKUPUSER.error
stopPLES 2>>stopPLES.error
redteamFUN 2>>redteamFUN.error
secureSSH 2>>secureSSH.error
secureSUDOER 2>>secureSUDOER.error
setupTERMINATOR 2>>setupTERMINATOR.error
setupFIREWALL 2>>setupFIREWALL.error

