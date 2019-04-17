# Because fuck windows server's internet explorer complaining about adding the "webpage to trustworthy domain" or something 

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install SysInternals 
choco install GoogleChrome

cd c:\ProgramData\chocolatey
echo "enjoy!"
