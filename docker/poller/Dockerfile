FROM ubuntu:16.04

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends -o Dpkg::Options::="--force-confold" ca-certificates curl jq && \
    rm -rf /var/lib/apt/lists/*

ADD poll.sh /

CMD ["/poll.sh"]
