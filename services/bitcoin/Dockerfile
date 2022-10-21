FROM ubuntu:22.04
WORKDIR /app

# LINK specifies where to download the binary from. If you adjust this, remember
# to update `checksum.txt` (the downloaded package is automatically renamed to
# `bitcoin.tar.gz`).
ARG LINK=https://bitcoincore.org/bin/bitcoin-core-23.0/bitcoin-23.0-x86_64-linux-gnu.tar.gz

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates wget

RUN adduser bitcoin
USER bitcoin

COPY . .

RUN bash setup.sh

ENTRYPOINT ["opt/bitcoin/bin/bitcoind", "-datadir=/data"]
