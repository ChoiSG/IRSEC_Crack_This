#!/bin/bash

#   init.sh
#   
#   Change credential of the users, setup backup user, install tools 
#

init(){
    mkdir /dev/string /dev/string/old_conf /dev/string/artifacts /dev/string/bin
    cd /dev/string
    echo "Init ...... DONE"
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

setupTOOLS() { 
    apt-get -qq install -y terminator tree curl wget vim entr 
    #apt-get install -y wireshark
    cp ./.vimrc ~/.vimrc
    echo "setupTOOLS........ DONE" 
}

setupBACKUPUSER() {
    useradd go
    echo "Tlqkfsus!" | passwd --stdin go
    usermod go -aG wheel go

    useradd watershell
    echo "diqkfsus!" | passwd --stdin watershell
    usermod watershell -aG wheel watershell 
}

init
changePASS
getUSERS
setupTOOLS
setupBACKUPUSER
