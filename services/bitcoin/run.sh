chown -R bitcoin:bitcoin /data

# TODO: setup DNS over VPN
if "${INSTALL_VPN}" == "true"; then
	echo ">> VPN enabled, setting up routes..."
	apt install -y iproute2
	# TODO: Delete:
	apt install -y curl iputils-ping dnsutils python3

	ip route del default
	ip route add default via 10.50.0.10

	echo ">> IP ROUTE:"
	ip route show

	echo ">> IP ADDRESS:"
	ip addr

	echo ">> ping 1.1.1.1"
	ping 1.1.1.1 -c 3

	echo ">> EXTERNAL IP"
	echo "$(curl -s ifconfig.me)"
fi

#/app/bitcoin/bin/bitcoind -datadir=/data
python3 -m http.server 8000
