# Change administrator account credential
net user administrator * 

# Disable RDP
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Terminal Services" /v fDenyTSConnections /t REG_DWORD /d 1 /f

# Stop scheduled tasks 
schtasks /delete /tn *

# Disable guest user 
net user guest /active:no

# Moving shutdown binary 
move c:\windows\system32\shutdown.exe c:\windows\system32\Tlqkf.exe

# Disabling smb
Set-SmbServerConfiguration -EnableSMB1Protocol $false


Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install SysInternals 
choco install GoogleChrome


# ================== Firewall Starts ====================

# Basic config things
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name =all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

Remove-NetFirewallRule -All

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall set rule group=”File and Printer Sharing” new enable=No


# Logging
netsh advfirewall set allprofiles logging filename \Windows\fw.log
netsh advfirewall set allprofiles logging maxfilesize 32676
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles settings inboundusernotification enable
