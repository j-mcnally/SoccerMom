SoccerMom
=========

A easy way to automate setting up SSH tunnels, specifically socks tunnels to make working remotely as seamless as possible.



Requirements
============

OSX 10.5+

Brew

Tunnel Setup
============

Basically your SSH jump off box.
A server inside your trusted network with sshd running, 
you will need access and you will want to add your SSH key to authorized_keys

We use an old linksys router running DD-WRT and it seems to work fine.




Usage
=====

Clone the repo to ~/.tunnel

Edit tunnel.ssh to reflect your tunneling needs, the script sets up a SOCKS server.
You could also program a bunch of LocalForwards and add Host lines to make those seamless

If you need to override your DNS you can add any host entries to tunnel.hosts
They should be formatted just like /etc/hosts
These host entries will only live while your tunnel is open.

The script will change your DNS servers to the google ones, if this is not acceptable you may modify the defaults in the tunnel-dns.sh script

Also you may also remove

```
    networksetup -setsocksfirewallproxy "$INTERFACE" 127.0.0.1 "5067"
    networksetup -setsocksfirewallproxystate "$INTERFACE" on
```

which will automatically setup your socks config when the tunnel opens

and

```
    networksetup -setsocksfirewallproxystate "$INTERFACE" off
    networksetup -setsocksfirewallproxystate "$INTERFACE" off
```


Contributing
============

I would love if someone better at bash conditionals could add settings for to use SOCKS or not 
and also if I dont get around to it the ability to list your own DNS servers.

Just fork the repo, create a branch and send a pull request when you are done.



