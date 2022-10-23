update-ca-certificates

# Download and verify bitcoin package
wget ${LINK} -O bitcoin.tar.gz
sha256sum -c checksum.txt
mkdir bitcoin
tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1

# Add bitcoin user
adduser --disabled-password --gecos "" bitcoin
