FROM ubuntu:xenial-20170802

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends -o Dpkg::Options::="--force-confold" ca-certificates curl jq gettext ncftp && \
    rm -rf /var/lib/apt/lists/*

ADD poll.sh testing.html.in /

CMD ["/poll.sh"]
