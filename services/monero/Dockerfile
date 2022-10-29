FROM ubuntu:22.04
WORKDIR /app

ARG DL_LINK
ARG CHECKSUM
ENV INSTALL_VPN=false
ENV GATEWAY=""

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates bzip2 iproute2 curl

RUN update-ca-certificates

COPY . .

# Download and verify Monero package
RUN curl $DL_LINK -o monero.tar.gz
RUN echo "${CHECKSUM} monero.tar.gz" > checksum.txt
RUN sha256sum -c checksum.txt
RUN mkdir monero && tar xvf monero.tar.gz -C monero --strip-components=1

CMD bash run.sh
