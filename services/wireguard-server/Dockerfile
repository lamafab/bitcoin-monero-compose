FROM ubuntu:22.04

# LINK specifies where to download the binary from. If you adjust this, remember
# to update `checksum.txt` (the downloaded package is automatically renamed to
# `monero.tar.bz2`).
ARG LINK=https://downloads.getmonero.org/cli/monero-linux-x64-v0.18.1.2.tar.bz2

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates wireguard

RUN update-ca-certificates

# Generate private key.
RUN wg genkey | tee /etc/wireguard/private.key > /dev/null
RUN chmod 400 /etc/wireguard/private.key

# Generate corresponding public key.
RUN cat /etc/wireguard/private.key | wg pubkey | tee /etc/wireguard/public.key
