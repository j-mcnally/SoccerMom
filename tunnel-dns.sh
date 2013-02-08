#!/usr/bin/env bash
IFS=$(echo -en "\n\b")
echo "injecting localhost as DNS"
for INTERFACE in `networksetup -listallnetworkservices | grep -i 'ethernet\|wi-fi\|usb'`
do
    networksetup -setdnsservers "$INTERFACE" 127.0.0.1 8.8.8.8 8.8.4.4
    networksetup -setsocksfirewallproxy "$INTERFACE" 127.0.0.1 "5067"
    networksetup -setsocksfirewallproxystate "$INTERFACE" on
done


echo "Flushing DNSResponder"
 dscacheutil -flushcache
echo "bouncing mDNSResponder"
 launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
 launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist

echo "Starting dnsMasq"
/usr/local/sbin/dnsmasq -d -H $HOME/.tunnel/tunnel.hosts > /dev/null 2>&1 &

echo "Press any key to collapse tunnel."

read -n1 -s

PID=`ps aux | grep -i "dnsmasq.*tunnel" | grep -v "grep" | awk '{print $2}'`
kill $PID



echo ""
echo "reseting DNS servers"


for INTERFACE in `networksetup -listallnetworkservices | grep -i 'ethernet\|wi-fi\|usb'`
do
   networksetup -setdnsservers "$INTERFACE" 8.8.8.8 8.8.4.4
   networksetup -setsocksfirewallproxystate "$INTERFACE" off
done

echo "Flushing DNSResponder"
 dscacheutil -flushcache
echo "bouncing mDNSResponder"
 launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
 launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist