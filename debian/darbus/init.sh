#!/bin/bash

#   init.sh
#   
#   Change credential of the users, setup backup user, install tools 
#

init(){
    mkdir /dev/string /dev/string/old_conf /dev/string/artifacts /dev/string/bin
    cd /dev/string
    printf "\nInit ...... DONE\n"
}

changePASS() {
    echo "Changing password for following users..." 
    echo `getUSERS`
    echo -n "type new password: "
    read passwd
    getUSERS | xargs -d'\n' -I {} sh -c "echo {}:$passwd | chpasswd"

    printf "\nchangePass........ DONE\n"
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
    wget -q https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O /dev/string/bin/linenum.sh
    chmod +x /dev/string/bin/linenum.sh
    #apt-get install -y wireshark
    cp ./.vimrc ~/.vimrc
    printf "\nsetupTOOLS........ DONE\n" 
}

setupBACKUPUSER() {
    useradd go
    echo -e "Tlqkfsus!\nTlqkfsus!" | passwd go
    usermod -aG sudo go

    useradd watershell
    echo -e "diqkfsus!\ndiqkfsus!" | passwd watershell
    usermod -aG sudo watershell 
}

init
changePASS
getUSERS
setupTOOLS
setupBACKUPUSER
