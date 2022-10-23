if "${INSTALL_VPN}" == "true"; then
	apt install -y iproute2
	ip route del default
	ip route add default via 10.0.0.1
fi

echo ">> IP ROUTE:"
ip route show

echo ">> IP ADDRESS:"
ip addr

#update-ca-certificates

# Download and verify bitcoin package
#wget ${LINK} -O bitcoin.tar.gz
#sha256sum -c checksum.txt
#mkdir bitcoin
#tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1
