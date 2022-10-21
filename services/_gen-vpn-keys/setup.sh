# Set permissions of created files for root-only
#umask 300
umask 000

gen_keys () {
	if [[ -f /data/$1 ]]; then
		SECKEY=$(cat "/data/$1")
		PUBKEY=$(echo $SECKEY | wg pubkey)
		echo $SECKEY $PUBKEY
	else
		SECKEY=$(wg genkey)
		PUBKEY=$(echo $SECKEY | wg pubkey)
		echo $SECKEY $PUBKEY
	fi
}

cp wireguard.conf wg0.conf

read SERVER_SECKEY SERVER_PUBKEY < <(gen_keys "vpn-server_private.key")

read BITCOIN_SECKEY BITCOIN_PUBKEY < <(gen_keys "bitcoin_private.key")

read LIGHTNING_SECKEY LIGHTNING_PUBKEY < <(gen_keys "lightning_private.key")

read MONERO_SECKEY MONERO_PUBKEY < <(gen_keys "monero_private.key")

sed -i "s|<VPN_SERVER_SECKEY>|'$SERVER_SECKEY'|" wg0.conf
sed -i "s|<BITCOIN_PUBKEY>|'$BITCOIN_PUBKEY'|" wg0.conf
sed -i "s|<LIGHTNING_PUBKEY>|'$LIGHTNING_PUBKEY'|" wg0.conf
sed -i "s|<MONERO_PUBKEY>|'$MONERO_PUBKEY'|" wg0.conf

cp wg0.conf /data

echo $SERVER_PUBKEY > /data/vpn-server_public.key
echo $BITCOIN_SECKEY > /data/bitcoin_private.key
echo $LIGHTNING_SECKEY > /data/lightning_private.key
echo $MONERO_SECKEY > /data/monero_private.key
