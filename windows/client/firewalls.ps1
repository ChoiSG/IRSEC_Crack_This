schtasks /delete /tn *
Services change logon /disable
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No

dir /B /S \windows\system32 > 32.txt
dir /B /S \*.exe > exes.txt
net share > shares.txt
net user > users.txt
net start > svcs.txt

get-localuser | where-object {$.name -notlike "Administrator"} | Disable-LocalUser


Remove-NetFirewallRule -All
#Flushes firewall Rules


Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallProfile -All -DefaultInboundAction Block -DefaultOutboundAction Block
#Sets the profiles to be on and block by default

New-NetFirewallRule -DisplayName "Allow InBound Port 53" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 53" -Direction Outbound -RemotePort 53 -Protocol UDP -Action Allow
#Allows Dns coming to our port 53 and dns Going only to their port 53

New-NetFirewallRule -DisplayName "Allow Inbound ICMP" -Direction Inbound -Protocol ICMPv4 -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound ICMP" -Direction Outbound -Protocol ICMPv4 -Action Allow
#Allows ICMP both inbound and outbound





