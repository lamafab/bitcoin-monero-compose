umask 077

SERVER_SECKEY=$(wg genkey)
SERVER_PUBKEY=$(echo $SERVER_SECKEY | wg pubkey)

BITCOIN_SECKEY=$(wg genkey)
BITCOIN_PUBKEY=$(echo $BITCOIN_SECKEY | wg pubkey)

LIGHTNING_SECKEY=$(wg genkey)
LIGHTNING_PUBKEY=$(echo $LIGHTNING_SECKEY | wg pubkey)

MONERO_SECKEY=$(wg genkey)
MONERO_PUBKEY=$(echo $MONERO_SECKEY | wg pubkey)

sed -i 's/<VPN_SERVER_SECKEY>/${VPN_SERVER_SECKEY}/g' wireguard.conf
sed -i 's/<BITCOIN_PUBKEY>/${BITCOIN_PUBKEY}/g' wireguard.conf
sed -i 's/<LIGHTNING_PUBKEY>/${LIGHTNING_PUBKEY}/g' wireguard.conf
sed -i 's/<MONERO_PUBKEY>/${MONERO_PUBKEY}/g' wireguard.conf

cp wireguard.conf /data

echo $SERVER_PUBKEY > /data/vpn-server_public.key
echo $BITCOIN_SECKEY > /data/bitcoin_private.key
echo $LIGHTNING_SECKEY > /data/lightning_private.key
echo $MONERO_SECKEY > /data/monero_private.key
