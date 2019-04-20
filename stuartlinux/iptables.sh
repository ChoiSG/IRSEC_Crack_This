#!/bin/sh

# Firewall rule for Elastic server 
# Includes SSH, HTTP, HTTPS, DNS, Elasticsearch (9200)

# Drop IPv6 stuffs
ip6tables -F
ip6tables -A INPUT -j DROP
ip6tables -A OUTPUT -j DROP
ip6tables -t mangle -P INPUT DROP
ip6tables -t mangle -P OUTPUT DROP

# Flush everything before beginning

iptables -F 
iptables -X 
iptables -t mangle -F
iptables -t mangle -X

# Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allowing established connections 
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


# ICMP 
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT 

# DNS - [taylor] only  
#iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p udp --sport 53 -j ACCEPT # Only for DEBUG
#iptables -A OUTPUT -p udp --dport 53 -d 10.0.0.0/24 -j ACCEPT # Accept DNS only from 10.0.0.0/24 network 

# SSH 
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Inbound http 
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow outbound http from this console; Use to download packages, visit google, etc.
#iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

#DHCP
#iptables -A INPUT -p udp --sport 67 --dport 68 -j ACCEPT

######## END OF FIREWALL ############

# Drop ALL OTHER THINGS 
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP


# DEBUG - UNcomment for SERVERS only  
sleep 15

iptables  -F
#iptables -F 
#iptables  -X
#iptables -X 
    