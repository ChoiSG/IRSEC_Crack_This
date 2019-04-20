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


echo "D" | xcopy C:\Windows\System32\dns C:\Users\Administrators\music /O /X /E /H /K

$fire = Get-Service -DisplayName "*Firew*” 
$fire | set-service -startuptype automatic
$fire | start-service
Get-NetFirewallRule | Remove-NetFirewallRule
get-netfirewallprofile | set-netfirewallprofile -enabled true
# Set up program paths for more security
$sys32 = "%systemroot%\system32\"
$lsass = $sys32 + "lsass.exe"
$dns = $sys32 + "dns.exe"
# An alias is required
Set-Alias nfw New-NetFirewallRule
# DNS Client + Server
nfw -DisplayName "DNS S In" -Direction Inbound -Action Allow -Protocol UDP -LocalPort 53  -RemotePort 1024-65535 -Program $dns
nfw -DisplayName "DNS S Out" -Direction Outbound -Action Allow -Protocol UDP -RemotePort 1024-65535 -LocalPort 53 -Program $dns
nfw -DisplayName "DNS C In" -Direction Inbound -Action Allow -Protocol UDP -RemotePort 53 -LocalPort 1024-65535 -Program $dns
nfw -DisplayName "DNS C Out" -Direction Outbound -Action Allow -Protocol UDP -LocalPort 1024-65535 -RemotePort 53 -Program $dns
# RPC
#nfw -DisplayName "RPCIn" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 135
#nfw -DisplayName "RPCOut" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 135
# LDAP and Kerberos (they both use the LSASS program, which is why they're grouped)
nfw -DisplayName "LDAP TCP In" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 389,636 -Program $lsass
nfw -DisplayName "LDAP TCP In" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 389,636 -Program $lsass

nfw -DisplayName "LDAP UDP In" -Direction Inbound -Action Allow -Protocol UDP -LocalPort 389 -Program $lsass
nfw -DisplayName "LDAP UDP Out" -Direction Outbound -Action Allow -Protocol UDP -LocalPort 389 -Program $lsass

#nfw -DisplayName "RPCIn" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 135,445 -remoteaddress 10.2.x.x
#nfw -DisplayName "RPCOut" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 135,445 -remoteaddress 10.2.x.x

#nfw -DisplayName "LDAP TCP In" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 389,636,3268,3269 -Program $lsass -remoteaddress 10.2.x.x
#nfw -DisplayName "LDAP TCP Out" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 389,636,3268,3269 -Program $lsass -remoteaddress 10.2.x.x

#nfw -DisplayName "Kerberos TCP In" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 88,464 -Program $lsass -remoteaddress 10.2.x.x
#nfw -DisplayName "Kerberos TCP Out" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 88,464 -program $lsass -remoteaddress 10.2.x.x
#nfw -DisplayName "Kerberos UDP In" -Direction Inbound -Action Allow -Protocol UDP -LocalPort 88,464 -program $lsass -remoteaddress 10.2.x.x
#nfw -DisplayName "Kerberos UDP Out" -Direction Outbound -Action Allow -Protocol UDP -LocalPort 88,464 -Program $lsass -remoteaddress 10.2.x.x
