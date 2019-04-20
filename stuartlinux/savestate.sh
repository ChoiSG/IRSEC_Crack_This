#!/bin/bash

#Save artifacts relating to users (persistent state)
getent passwd > passwd.backup
getent group > group.backup
cat /etc/sudoers > sudoers.backup
cat ~/.bashrc > bashrc.backup
crontab -l > cron.backup

#Save artifacts relating to processes (current state)
ps aux > ps.backup
netstat -ptuna > netstat.backup
service --status-all > service.backup
systemctl -l --type service --all > systemctl.backup
sysctl -a > sysctl.backup


for user in $(cut -f1 -d: /etc/passwd); crontab -u $user -l >> cron2.backup; done
