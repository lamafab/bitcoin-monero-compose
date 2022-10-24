FROM ubuntu:22.04
WORKDIR /app

# LINK specifies where to download the binary from. If you adjust this, remember
# to update `checksum.txt` (the downloaded package is automatically renamed to
# `bitcoin.tar.gz`).
ARG LINK=https://bitcoincore.org/bin/bitcoin-core-23.0/bitcoin-23.0-x86_64-linux-gnu.tar.gz

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates iproute2 curl


RUN update-ca-certificates

COPY . .

# Download and verify bitcoin package
RUN curl ${LINK} -o bitcoin.tar.gz
RUN sha256sum -c checksum.txt
RUN mkdir bitcoin
RUN tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1

CMD bash run.sh
