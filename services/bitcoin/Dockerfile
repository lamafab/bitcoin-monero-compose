FROM ubuntu:22.04

ARG VERSION=23.0
ARG LINK=https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates wget

RUN update-ca-certificates

COPY checksums.txt .

RUN wget ${LINK} -O bitcoin.tar.gz
RUN sha256sum -c checksums.txt
RUN mkdir bitcoin && tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1

ENTRYPOINT ["bitcoin/bin/bitcoind", "-datadir=/data"]
