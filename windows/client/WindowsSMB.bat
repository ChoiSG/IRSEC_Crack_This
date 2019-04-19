schtasks /delete /tn *
Services change logon /disable

dir /B /S \windows\system32 > 32.txt
dir /B /S \*.exe > exes.txt
net share > shares.txt
net user > users.txt
net start > svcs.txt
