FROM ubuntu:18.04

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
    ca-certificates curl jq moreutils python phantomjs locales && \
    rm -rf /var/lib/apt/lists/* && \
    locale -a && \
    curl -fsS --retry 4 -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl

ADD yt.sh /

WORKDIR /work

CMD ["/yt.sh"]
