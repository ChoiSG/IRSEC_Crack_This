#!/bin/sh

#	author: choi 
#	description: Fivemin plan for ubuntu-cloud, HTTP server. 
#	Made for IRSEC 2019
#
#

# 	TODO 
#   1. chattr stuffs 
#


setupBACKUPUSER() {
    useradd go
    echo "Tlqkfsus!" | passwd --stdin go
    usermod go -aG wheel go 
}

setupTOOLS() { 
    yum install -y epel-release
    yum --disablerepo=epel -y update  ca-certificates
    yum install -y terminator
	yum install -y tree
    yum install -y curl 
    yum install -y vim 
	#apt-get install -y wireshark
	cp ./.vimrc ~/.vimrc
    echo "setupTOOLS........ DONE" 
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
    echo "redteamFUN........ DONE"
}

secureSSH() {
    #SSH
    yum remove -y openssh-clients openssh-server
    yum install -y openssh-clients openssh-server
    
    setenforce 0
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

backupWEB() { 
	# if nginx --> Check for headshot. Follow the headshot plan.
	if [ -n "$(command -v nginx)" ]; then 
		hs=`nginx -V 2>&1`
		if [ $(echo $hs | wc -c) -lt 500 ]; then 
			printf "\nPossible HEADSHOT FOUND!!!\n"
			touch "HEADSHOT_FOUND_FOLLOW_PROCEDURES"
			printf "\n"
		fi

		tar -czvf "./nginx_backup.tar.gz" /etc/nginx/ /usr/share/nginx/ /usr/lib/nginx/

	elif [ -n "$(command -v apache2)" ]; then 
		tar -czvf "./apache2_backup.tar.gz" /etc/apache2/ /var/www/html/
	fi
}

revhunter() {
	revhunterz='if [ "$(tty)" == "not a tty" ]; then kill -9 $PPID; fi'
	echo $revhunterz > /bin/rev
	chmod 755 /bin/rev
	echo "export PROMPT_COMMAND='/bin/rev'" >> /etc/bashrc
	
}

securePAM() {
    cp ./common-auth /etc/pam.d/common-auth
}


############# MAIN FUNC ##############

# DEBUG MODE 
if [[ $1 == "debug" ]]; then 
    echo "Debug mode..."

    rm -rf ./fun
    echo "Removing ./fun dir........ DONE"

    rm *.error
    echo "Removing all error files........ DONE"

	rm HEADSHOT_FOUND_FOLLOW_PROCEDURES nginx_backup.tar.gz
	echo "Removing all misc files........ Done"

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
setupTOOLS 2>>setupTOOLS.error
backupWEB 2>>backupWEB.error
revhunter 2>>revhunter.error
securePAM 2>>securePAM.error
setupFIREWALL 2>>setupFIREWALL.error

