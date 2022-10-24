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
