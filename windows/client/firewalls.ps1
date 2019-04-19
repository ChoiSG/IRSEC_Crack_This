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


New-NetFirewallRule -DisplayName "Allow InBound Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 80" -Direction Outbound -RemotePort 80 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow InBound Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 443" -Direction Outbound -RemotePort 443 -Protocol TCP -Action Allow
#Web Client acces



#All LDAP rules.
New-NetFirewallRule -DisplayName "Allow InBound  TCP Port 389" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 389" -Direction Outbound -RemotePort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow InBound UDP Port 389" -Direction Inbound -LocalPort 389 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 389" -Direction Outbound -RemotePort 389 -Protocol UDP -Action Allow

New-NetFirewallRule -DisplayName "Allow InBound Port 636" -Direction Inbound -LocalPort 636 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 636" -Direction Outbound -RemotePort 636 -Protocol TCP -Action Allow

New-NetFirewallRule -DisplayName "Allow InBound Port 3268" -Direction Inbound -LocalPort 3268 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 3268" -Direction Outbound -RemotePort 3268 -Protocol TCP -Action Allow

New-NetFirewallRule -DisplayName "Allow InBound Port 3269" -Direction Inbound -LocalPort 3269 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 3269" -Direction Outbound -RemotePort 3269 -Protocol TCP -Action Allow




#groups policy goes on above rules as well as the ones below

New-NetFirewallRule -DisplayName "Allow InBound TCP Port 445" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 445" -Direction Outbound -RemotePort 445 -Protocol TCP -Action Allow

New-NetFirewallRule -DisplayName "Allow InBound UDP Port 445" -Direction Inbound -LocalPort 445 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 445" -Direction Outbound -RemotePort 445 -Protocol UDP -Action Allow

New-NetFirewallRule -DisplayName "Allow InBound UDP Port 138" -Direction Inbound -LocalPort 138 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 138" -Direction Outbound -RemotePort 138 -Protocol UDP -Action Allow


#ports found here https://support.microsoft.com/en-us/help/179442/how-to-configure-a-firewall-for-domains-and-trusts
# and here https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10)



