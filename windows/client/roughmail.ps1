Remove-NetFirewallRule -All




Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallProfile -All -DefaultInboundAction Block -DefaultOutboundAction Block


New-NetFirewallRule -DisplayName "Allow InBound  TCP Port 25" -Direction Inbound -LocalPort 25 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 25" -Direction Outbound -RemotePort 25 -Protocol TCP -Action Allow










New-NetFirewallRule -DisplayName "Allow InBound Port 53" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 53" -Direction Outbound -RemotePort 53 -Protocol UDP -Action Allow


New-NetFirewallRule -DisplayName "Allow Inbound ICMP" -Direction Inbound -Protocol ICMPv4 -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound ICMP" -Direction Outbound -Protocol ICMPv4 -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound  TCP Port 389" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 389" -Direction Outbound -RemotePort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow InBound UDP Port 389" -Direction Inbound -LocalPort 389 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 389" -Direction Outbound -RemotePort 389 -Protocol UDP -Action Allow




New-NetFirewallRule -DisplayName "Allow InBound  TCP Port 464" -Direction Inbound -LocalPort 464 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 389" -Direction Outbound -RemotePort 464 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow InBound UDP Port 464" -Direction Inbound -LocalPort 464 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 464" -Direction Outbound -RemotePort 389 -Protocol UDP -Action Allow






New-NetFirewallRule -DisplayName "Allow InBound UDP Port 88" -Direction Inbound -LocalPort 88 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 88" -Direction Outbound -RemotePort 88 -Protocol UDP -Action Allow




New-NetFirewallRule -DisplayName "Allow InBound Port 3268" -Direction Inbound -LocalPort 3268 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 3268" -Direction Outbound -RemotePort 3268 -Protocol TCP -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound Port 3269" -Direction Inbound -LocalPort 3269 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound Port 3269" -Direction Outbound -RemotePort 3269 -Protocol TCP -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound TCP Port 445" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound TCP Port 445" -Direction Outbound -RemotePort 445 -Protocol TCP -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound UDP Port 445" -Direction Inbound -LocalPort 445 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 445" -Direction Outbound -RemotePort 445 -Protocol UDP -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound UDP Port 138" -Direction Inbound -LocalPort 138 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 138" -Direction Outbound -RemotePort 138 -Protocol UDP -Action Allow


New-NetFirewallRule -DisplayName "Allow InBound UDP Port 139" -Direction Inbound -LocalPort 139 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow Outbound UDP Port 139" -Direction Outbound -RemotePort 139 -Protocol TCP -Action Allow