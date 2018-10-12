FROM alpine

RUN apk update && apk add git npm nodejs && \
    mkdir -p /srv && cd /srv && \
    git clone https://github.com/taigaio/taiga-events.git taiga-events && \
    cd taiga-events && cp config.example.json config.json && \
    npm install && npm install -g coffee-script && \
    apk del git npm && \
    rm -rf /var/cache/apk/*

WORKDIR /srv/taiga-events
CMD ["coffee", "index.coffee"]
