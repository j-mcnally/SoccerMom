#!/usr/bin/env bash

echo "Installing DNSMasq for optional DNS editing"
brew install dnsmasq

echo "Installing symlink to /usr/local/bin"
sudo ln -s $HOME/.tunnel/tunnel /usr/local/bin/tunnel


echo "If you havent please set your SSH key on the proxy server."

echo "You can edit your specific tunnel settings in $HOME/.tunnel/tunnel.ssh"

echo "If your tunnel has specific DNS requirements you can set those in $HOME/.tunnel/tunnel.hosts"