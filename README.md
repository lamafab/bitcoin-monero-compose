# About

This repository contains Docker Compose files for running a Bitcoin and/or a
Monero node inside a container, including - if desired - VPN configuration to
hide the IP address of the nodes.

## Requirements

* Docker Compose

## Setup

This repo contains two Docker Compose files, depending on whether a VPN
connection should be established or not.

* `docker-compose.nodes-no-vpn.yml`
* `docker-compose.nodes-with-vpn.yml`

Be default, all the (persistent) data generated by `bitcoind` and `monerod` is
saved to `./mounts`. This includes blochain data, states and other configuration
files.

### No-VPN Setup

Copy the appropriate file and give it a name:

```bash
cp docker-compose.nodes-no-vpn.yml my-setup.yml
```

Then open the file and adjust the `CLI_ARGS` environment variable according to
you needs. Those arguments are passed on directly to `bitcoind` and `monerdo`,
respectively. Those arguments are application specific and not documented here.

This is the only thing you need to adjust (marked `ADJUST`). You're free to
change mount options, etc.

#### Run from CLI

To run the Docker Compose file:

* Run a Bitcoin node only:
	* `docker compose -f my-setup.yml --profile bitcoin up`
* Run a Monero node only:
	* `docker compose -f my-setup.yml --profile monero up`
* Run both a Bitcoin and a Monero node:
	* `docker compose -f my-setup.yml --profile bitcoin --profile monero up`

That's it. You might want to run this in `tmux` so you can detach and logout of
the machine, for example. Alternatively, see [Run in background
(systemd)](#run-in-background-systemd)

#### Run in background (systemd)

TODO

# Client

```ini
# Client
[Interface]
PrivateKey = <PRIVATE-KEY>
Address = 10.50.0.50/32

# VPN Server
[Peer]
PublicKey = <PUBLIC-KEY>
AllowedIPs = 0.0.0.0/0
# VPN Endpoint IP
Endpoint = IP-ADDRESS:51820
```

# VPN Server

sudo nano /etc/sysctl.conf
sudo sysctl -p

sudo iptables -A FORWARD -i wg0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o ens4 -j MASQUERADE

Add config to `/etc/wireguard/wg0.conf`:

```ini
[Interface]
ListenPort = 51820
PrivateKey = <PRIVATE-KEY>
#
# Allow forwarding from the VPN network (to the internet)
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT
# Enable NAT/masquerading when accessing internet
PostUp = iptables -t nat -A POSTROUTING -o ens4 -j MASQUERADE
# Allow forwarding from the internet (to the VPN network)
PostUp = iptables -A FORWARD -i ens4 -j ACCEPT
#
# Forward port 8000 to client
PostUp = iptables -t nat -A PREROUTING -i ens4 -p tcp --dport 8000 -j DNAT --to-destination 10.50.0.20:8000
#
## DROP rules, just the reverse of the above
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT;
PostDown = iptables -t nat -D POSTROUTING -o ens4 -j MASQUERADE
PostDown = iptables -D FORWARD -i ens4 -j ACCEPT
PostDown = iptables -t nat -D PREROUTING -i ens4 -p tcp --dport 8000 -j DNAT --to-destination 10.50.0.20:8000

[Peer]
PublicKey = <PUBLIC-KEY>
AllowedIPs = 10.50.0.0/24
```

Then:

```bash
sudo wg-quick up wg0
# (Optional) Enable on startup:
sudo systemctl enable wg-quick@wg0.service
```
