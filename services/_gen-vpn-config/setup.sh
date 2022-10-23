# Set permissions of created files for root-only.
umask 077

# Generates a new client keypair, if not present yet.
gen_keys () {
	if [ ! -e /data/wg_${1}_client.conf ]; then
		echo "GENERATING new keypair for ${1}"
		SEC_KEY=$(wg genkey) && PUB_KEY=$(echo $SEC_KEY | wg pubkey)

		# Update client
		cp client.conf wg_${1}_client.conf
		sed -i "s|<CLIENT_SECKEY>|$SEC_KEY|" wg_${1}_client.conf
		sed -i "s|<CLIENT_IP>|$2|" wg_${1}_client.conf

		# Update server config
		sed -i "s|<${1^^}_PUBKEY>|$PUB_KEY|" wg_vpn_server.conf
	# ... otherwise skip.
	else
		echo "FOUND existing wg_${1}_client.conf, skipping..."
	fi
}

cp wireguard_server.conf wg_vpn_server.conf
cp wireguard_client.conf client.conf

# Generates the VPN server keypair, if not present yet.
if [ ! -e /data/wg_vpn_server.conf ]; then
	echo "GENERATING new VPN server keypair"
	VPN_SK=$(wg genkey) && VPN_PK=$(echo $VPN_SK | wg pubkey)

	sed -i "s|<VPN_SERVER_SECKEY>|$VPN_SK|" wg_vpn_server.conf
	sed -i "s|<VPN_SERVER_PUBKEY>|$VPN_PK|" client.conf
else
	echo "FOUND existing VPN server config, skipping..."
fi

gen_keys "bitcoin"	10.1.0.2
gen_keys "lightning" 10.2.0.2
gen_keys "monero" 10.3.0.2

cp wg_* /data
