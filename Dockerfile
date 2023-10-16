FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai


RUN set -e \
    && apt-get update \
    && apt-get install --no-install-recommends -y nginx redis ca-certificates \
    && apt-get install --no-install-recommends -y \
    php php-curl php-fpm php-json php-redis php-xml \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

COPY liveapirender.conf /etc/nginx/conf.d/
COPY run.sh /root/
RUN set -e \
    && rm /etc/nginx/sites-enabled/default \
    && chmod +x /root/run.sh
ADD ./ /var/www/liveapirender
RUN chmod -Rf 777 /var/www/liveapirender

EXPOSE 443

CMD ["/root/run.sh"]
