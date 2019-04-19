| Method of Hiding | Method of fixing | Five Min Plan Fixes?  |
|----------|------------------------|---|
| ***Code re-running (Tasks)*** | | |
| .bashrc       | look at bashrc, remove bad lines |  N |
| Cron | Uninstall cron, stop cron  | Y |
| Malicious Service Added | `systemctl list-unit-files` or `service --status-all`  | N  |
| Random processes running | `ps faux`, `pwdx pid` | N |
| ***Letting red team log in directly*** | | |
| Extra Users | remove the users  | N  |
| Pam Backdoor | Fix pam config? Set UsePam: No in sshd_config  | N  |
| NoLogin | make sure `nologin`,`false` isn't a shell| N |
| ***Ways to connect without logging in*** | | |
| reverse shell | iptables | Y  |
| Service Specific Backdoors (headshot, web shell) | See (Service Specific)  | N |
| Watershell | `lsof \| grep -i raw`, `kill -9 pid` | N |
| ***This doesn't make sense?!***| | | 
| Rootkit | `lsmod`,`modinfo name`,`rmmod`,`nano /etc/modprobe.d/blacklist.conf`,`reboot`  | N |

Service Specific Backdoors:

| Service | Method | How to fix  |
|----------|------------------------|----------|
| Web | webshell | grep for system/exec in /var/www. If the file seems susp, remove it. |
| Nginx | Headshot | `nginx -V` looks for modules, reinstall it. |
| MySql | @choi | @choi | 
| SSH | Backdoored binary | Reinstall ssh |

Not sure where to put this:
Spy on any new processes:
https://raw.githubusercontent.com/brendangregg/perf-tools/master/execsnoop
