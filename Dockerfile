FROM kalicki2k/alpine-base

MAINTAINER Sebastian Kalicki (https://github.com/kalicki2k)

COPY Dockerfiles/. /

RUN apk update && apk upgrade && \
    apk add nginx && \
    mkdir /run/nginx/ && \
    chmod +x /run.sh && \
    rm -rf /var/cache/apk/*

EXPOSE 80 443

ENTRYPOINT ["/run.sh"]
