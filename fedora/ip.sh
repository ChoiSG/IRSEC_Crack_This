#!/bin/bash

ip="iptables -t mangle"

in_ports="25 110 143"

ip6tables -F
ip6tables -X
ip6tables -t mangle -F
ip6tables -t mangle -X
ip6tables -t mangle -P INPUT DROP
ip6tables -t mangle -P OUTPUT DROP

$ip -P INPUT DROP
$ip -P OUTPUT DROP

iptables -F
iptables -X
$ip -F
$ip -X

$ip -A INPUT -i lo -j ACCEPT
$ip -A OUTPUT -o lo -j ACCEPT

for p in $in_ports; do
	$ip -A INPUT -p tcp --dport $p -j ACCEPT
	$ip -A OUTPUT -p tcp --sport $p -m state --state EST,REL -j ACCEPT
done

$ip -A INPUT -j DROP
$ip -A OUTPUT -j DROP
