if "${INSTALL_VPN}" == "true"; then
	# TODO
	apt-get install -y wireguard iproute2
fi

#update-ca-certificates

# Download and verify bitcoin package
#wget ${LINK} -O bitcoin.tar.gz
#sha256sum -c checksum.txt
#mkdir bitcoin
#tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1
