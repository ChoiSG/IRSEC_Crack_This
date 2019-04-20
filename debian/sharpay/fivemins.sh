#!/usr/bin/env bash

ip6tables -F
ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -A INPUT -j DROP
ip6tables -A INPUT -j DROP

iptables -F
iptables -X

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCETP

iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -m multiport --dport 80,443 -m conntrack -ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sport 80,443 -m conntrack -ctstate NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
