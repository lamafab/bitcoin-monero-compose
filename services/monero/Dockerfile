FROM ubuntu:22.04

# LINK specifies where to download the binary from. If you adjust this, remember
# to update `checksum.txt` (the downloaded package is automatically renamed to
# `monero.tar.bz2`).
ARG LINK=https://downloads.getmonero.org/cli/monero-linux-x64-v0.18.1.2.tar.bz2

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates bzip2 iproute2 curl

RUN update-ca-certificates

COPY . .

RUN curl ${LINK} -o monero.tar.bz2
RUN sha256sum -c checksum.txt
RUN mkdir monero && tar xvf monero.tar.bz2 -C monero --strip-components=1

CMD bash run.sh
