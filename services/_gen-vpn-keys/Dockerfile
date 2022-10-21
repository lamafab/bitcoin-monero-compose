FROM ubuntu:22.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    wireguard

WORKDIR /app

COPY . .

CMD bash /app/setup.sh
