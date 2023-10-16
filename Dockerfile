FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai


RUN set -e \
    && apt-get update \
    && apt-get install --no-install-recommends -y nginx git redis ca-certificates \
    && apt-get install --no-install-recommends -y \
    php php-curl php-fpm \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

COPY liveapirender.conf /etc/nginx/conf.d/
COPY run.sh /root/
RUN set -e \
    && rm /etc/nginx/sites-enabled/default \
    && git clone https://github.com/cooliceycold/liveapirender.git /var/www/liveapirender \
    && chmod -Rf 777 /var/www/liveapirender

EXPOSE 443

CMD ["/root/run.sh"]
