chown -R bitcoin:bitcoin /data

# TODO: setup DNS over VPN
if "${INSTALL_VPN}" == "true"; then
	echo ">> VPN enabled, setting up routes..."
	apt install -y iproute2

	ip route del default
	ip route add default via 10.66.0.50

	echo ">> IP ROUTE:"
	ip route show

	echo ">> IP ADDRESS:"
	ip addr

	echo "I AM"
	whoami
fi

/app/bitcoin/bin/bitcoind -datadir=/data