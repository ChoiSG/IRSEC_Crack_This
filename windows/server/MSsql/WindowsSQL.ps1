schtasks > C:\Users\principal\tasks.txt
schtasks /delete /tn * /f



Services change logon /disable
#if box bluescreens comment this line out ^^^


reg add "HKLM\Software\Policies\Microsoft\Windows NT\Terminal Services" /v fDenyTSConnections /t REG_DWORD /d 1 /f
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
del c:/windows/system32/sethc.exe
dir \windows\system32 > 32.txt
dir \*.exe > exes.txt
net share > shares.txt
net user > users.txt
net start > svcs.txt
auditpol /set /category:* /success:enable
auditpol /set /category:* /failure:enable

get-localuser | where-object {$.name -notlike "principal"} | Disable-LocalUser


Remove-NetFirewallRule -All
#Flushes firewall Rules


Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallProfile -All -DefaultInboundAction Block -DefaultOutboundAction Block
#Sets the profiles to be on and block by default

netsh advfirewall firewall add rule name="Allow from AD" dir=in action=allow protocol=ANY -remoteaddress 10.2.x.1
netsh advfirewall firewall add rule name="Allow to AD" dir=out action=allow protocol=ANY -remoteaddress 10.2.x.1
#everything to AD

New-NetFirewallRule -DisplayName "Allow Inbound ICMP" -Direction Inbound -Protocol ICMPv4 -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound ICMP" -Direction Outbound -Protocol ICMPv4 -Action Allow
#Allows ICMP both inbound and outbound

New-NetFirewallRule -DisplayName "SQL" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1433
New-NetFirewallRule -DisplayName "SQL" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 1433

New-NetFirewallRule -DisplayName "SQL" -Direction Inbound -Action Allow -Protocol UDP -LocalPort 1434
New-NetFirewallRule -DisplayName "SQL" -Direction Outbound -Action Allow -Protocol UDP -LocalPort 1434
