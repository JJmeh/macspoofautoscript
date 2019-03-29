#!/usr/bin/env bash

interface=${1?Error : Please input network interface} 

echo "spoofing mac address..."

service network-manager stop
ifconfig $interface down
ip link set $interface down
macchanger -a $interface
service network-manager start
ifconfig $interface up
ip link set $interface up
echo
echo "your new mac address : $(ifconfig $interface | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')"
echo
sleep 2
exit