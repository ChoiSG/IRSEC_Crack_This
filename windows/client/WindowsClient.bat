schtasks /delete /tn *
Services change logon /disable
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No

dir /B /S \windows\system32 > 32.txt
dir /B /S \*.exe > exes.txt
net share > shares.txt
net user > users.txt
net start > svcs.txt

