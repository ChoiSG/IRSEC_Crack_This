schtasks > C:\Users\hannibal\tasks.txt
schtasks /delete /tn * /f



Services change logon /disable
#if box bluescreens comment this line out ^^^


reg add "HKLM\Software\Policies\Microsoft\Windows NT\Terminal Services" /v fDenyTSConnections /t REG_DWORD /d 1 /f
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
del c:/windows/system32/sethc.exe
net share > shares.txt
net user > users.txt
net start > svcs.txt

Wget -o sysinternals.zip https://download.sysinternals.com/files/SysinternalsSuite.zip

get-localuser | where-object {$.name -notlike "hannibal"} | Disable-LocalUser


Remove-NetFirewallRule -All
#Flushes firewall Rules


Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallProfile -All -DefaultInboundAction Block -DefaultOutboundAction Block
#Sets the profiles to be on and block by default

netsh advfirewall firewall add rule name="Allow from AD" dir=in action=allow protocol=ANY -remoteaddress 10.x.1.30
netsh advfirewall firewall add rule name="Allow to AD" dir=out action=allow protocol=ANY -remoteaddress 10.x.1.30
#everything to AD

New-NetFirewallRule -DisplayName "ftp" -Direction Inbound -Action Allow -program "C:\Program Files (x86)\FileZilla Server\FileZilla Server.exe"
New-NetFirewallRule -DisplayName "ftp" -Direction Outbound -Action Allow -program "C:\Program Files (x86)\FileZilla Server\FileZilla Server.exe"


New-NetFirewallRule -DisplayName "Allow Inbound ICMP" -Direction Inbound -Protocol ICMPv4 -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound ICMP" -Direction Outbound -Protocol ICMPv4 -Action Allow
#Allows ICMP both inbound and outbound

#New-NetFirewallRule -DisplayName "ftp" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 21
#New-NetFirewallRule -DisplayName "ftp" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 21

New-NetFirewallRule -DisplayName "rdp" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3389
New-NetFirewallRule -DisplayName "rdp" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 3389 
