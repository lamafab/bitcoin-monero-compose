```bash
docker network create --subnet 10.66.0.0/24 wgnet
```

# VPN Server

sudo nano /etc/sysctl.conf
sudo sysctl -p

Add config to `/etc/wireguard/wg0.conf`:

```ini
# VPN Server
[Interface]
PrivateKey = <CLIENT_SECKEY>
ListenPort = 51820

# Client
[Peer]
PublicKey = <VPN_SERVER_PUBKEY>
AllowedIPs = 10.66.0.50/32
```

Setup device interface:

```bash
sudo apt install -y wireguard
sudo ip link add dev wg0 type wireguard
sudo ip address add dev wg0 10.66.0.100/24
sudo wg setconf wg0 /etc/wireguard/wg0.conf
sudo ip link set up dev wg0
```
