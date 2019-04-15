#!/bin/bash

: ' 
Name: Headshothunter.sh
Description: Headshot is a malicious nginx module which hooks http_request and 
checks for a specific header. When the attacker uses the header, nginx will 
perform a RCE. For ex) curl localhost --header "Headshot: ls -alh /tmp" will perform
a RCE.

Everything depends on the red team. 

This is more of a guide, NOT a shell script. 

If nginx is compiled with headshot, the configure would only contain --add-module=../
To find this out, do "nginx -V". 

Also, if /etc/nginx and /usr/share/nginx does NOT exist, that is possible headshotted nginx.

'

printf "\n\n"

echo "[+] 'Curl'ing for headshot..."
echo "[+] It's hardcoded, don't believe this outcome..."
curl -v --silent localhost --header "Headshot: whoami" 2>&1 | grep root
if [ $? -eq 0 ]; then
    echo "[!!!] Headshot found [!!!] "
fi
printf "\n"

echo "[+] Checking for nginx.service... if not found, possible headshot"
service nginx status
printf "\n"

echo "[+] Checking for /etc/nginx directory... if not found, possible headshot"
ls -alh /etc/nginx
printf "\n"

echo "[+] Checking for nginx version, if it's 1.15.0 then possible headshot..." 
/usr/local/nginx/sbin/nginx -v 
printf "\n"

echo "[+] Checking for nginx compiling information. If it only contains"
echo "[+] configure arguments: --add-modules=../"
echo "[+] Then it is 100% Headshot."
/usr/local/nginx/sbin/nginx -V 

printf "\n"
echo "If it is headshot, backup everything"
echo "cp -r /usr/local/nginx /tmp/nginx_backup"
printf "\n"
echo "Then reinstall nginx, and move back all conf and html files"
echo "back to /etc/nginx and /usr/share/nginx/html"
