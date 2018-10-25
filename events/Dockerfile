FROM alpine

RUN apk update && apk add git npm nodejs && \
    mkdir -p /srv && cd /srv && \
    git clone https://github.com/taigaio/taiga-events.git taiga-events && \
    cd taiga-events && \
    npm install && npm install -g coffee-script && \
    adduser -SDH -s /sbin/nologin taiga-events && \
    apk del git npm && \
    rm -rf /var/cache/apk/* && rm -rf /srv/taiga-events/.git

WORKDIR /srv/taiga-events
USER taiga-events
CMD ["coffee", "index.coffee", "--config", "/run/secrets/config.json"]
