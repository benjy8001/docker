FROM docker

RUN set -xe \
 && apk add --no-cache \
      make \
 && apk add --no-cache --virtual .build-deps \
      gcc \
      libffi-dev \
      musl-dev \
      openssl-dev \
 && apk add curl \
 && curl -L "https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose \
 && apk del --no-network .build-deps \
 && rm -rf ~/.cache
