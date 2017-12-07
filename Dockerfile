FROM kalicki2k/alpine-base:3.6

MAINTAINER Sebastian Kalicki (https://github.com/kalicki2k)

COPY Dockerfiles/. /

RUN apk update && apk upgrade && \
    apk add nginx && \
    mkdir /run/nginx/ && \
    chmod +x /run.sh && \
    rm -rf /var/cache/apk/*

WORKDIR /var/www/localhost

EXPOSE 80 443

ENTRYPOINT ["/run.sh"]
