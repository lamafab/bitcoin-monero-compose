if "${INSTALL_VPN}" == "true"; then
	apt-get install -y wireguard
	SEC_KEY=$(wg genkey)
	PUB_KEY=$(echo $SEC_KEY | wg pubkey)

	sed -i 's/<BITCOIN_SECKEY>/${SEC_KEY}/g' wireguard.conf
fi

update-ca-certificates

# Download and verify bitcoin package
wget ${LINK} -O bitcoin.tar.gz
sha256sum -c checksum.txt
mkdir bitcoin
tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1
