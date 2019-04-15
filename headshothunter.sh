#!/bin/bash

: ' 
author: choi
Name: Headshothunter.sh
Description: Headshot (https://github.com/RITRedteam/Headshot) is a malicious nginx module which hooks http_request and 
checks for a specific header. When the attacker uses the header, nginx will 
perform a RCE. For ex) curl localhost --header "Headshot: ls -alh /tmp" will perform
a RCE.

Everything depends on the red team. 

HOWEVER, as of right now, Headshot can be only made/installed through manual
binary compiling. In this case, all of nginx files would be in 
/usr/local/nginx instead of the typical /usr/share/nginx and /etc/nginx. 

<Note> If nginx -v is 1.15.0, then it has a high chance of being headshot.

'

printf "\n\n"

echo "'Curl'ing for headshot..."
echo "It's hardcoded, don't believe this outcome..."
curl -v --silent localhost --header "Headshot: whoami" 2>&1 | grep root
if [ $? -eq 0 ]; then
    echo "[!!!] Headshot found [!!!] "
fi
printf "\n"

echo "Checking for nginx.service..."
service nginx status
printf "\n"

echo "Checking for /etc/nginx directory..."
ls -alh /etc/nginx
printf "\n"

echo "Checking for /usr/local/nginx directory..." 
ls -alh /usr/local/nginx

if [ $? -eq 0 ]; then
    printf "\n" 
    echo "/usr/local/nginx found. Possibly headshotted nginx!"
    echo "Copying all html, conf, and log files to /tmp/nginx_backup"
    echo "Take a look around, take screenshots, and erase nginx"
    echo "Re-install nginx with apt-get install nginx or yum install nginx"
    cp -r /usr/local/nginx /tmp/nginx_backup
    printf "\n"
    echo "Copying done. reinstall nginx, copy back conf and .html files"
else
    echo "Headshot NOT found."
fi

printf "\n"
