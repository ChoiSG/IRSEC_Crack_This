schtasks /delete /tn *
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No

dir /B /S \windows\system32 > 32.txt
dir /B /S \*.exe > exes.txt
net share > shares.txt
net user > users.txt
net start > svcs.txt
C:\Windows\System32\inetsrv\appcmd.exe add backup "robert"

xcopy C:\Windows\System32\inetsrv C:\Users\Administrators\videos /O /X /E /H /K
