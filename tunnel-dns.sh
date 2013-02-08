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

echo "starting DNSmasq.... press Ctrl+C to exit"
 sudo dnsmasq -d -H $HOME/.tunnel/tunnel.hosts
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