FROM ubuntu:22.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates wireguard

RUN update-ca-certificates

# Generate private key.
RUN wg genkey | tee /etc/wireguard/private.key > /dev/null
RUN chmod 400 /etc/wireguard/private.key

# Generate corresponding public key.
RUN cat /etc/wireguard/private.key | wg pubkey | tee /etc/wireguard/public.key
