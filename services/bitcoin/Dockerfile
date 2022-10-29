FROM ubuntu:22.04
WORKDIR /app

ARG DL_LINK
ARG CHECKSUM

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates iproute2 curl

RUN update-ca-certificates

COPY . .

# Download and verify Bitcoin package
RUN curl $DL_LINK -o bitcoin.tar.gz
RUN echo "${CHECKSUM} bitcoin.tar.gz" > checksum.txt
RUN sha256sum -c checksum.txt
RUN tar xvzf bitcoin.tar.gz -C bitcoin --strip-components=1

CMD bash run.sh
