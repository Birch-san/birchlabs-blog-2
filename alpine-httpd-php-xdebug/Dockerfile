FROM alpine:3.6

EXPOSE 80
EXPOSE 443

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk add --no-cache \
apache2 \
apache2-http2 \
apache2-ssl \
php7 \
php7-apache2 \
php7-xdebug@testing \
# remove bash if you want an even lighter image
bash

COPY from_host /from_host

# Create symlinks PHP -> PHP7
RUN mv /from_host/xdebug.ini /etc/php7/conf.d/xdebug.ini \
&& mv /from_host/httpd.conf /etc/apache2/ \
# Apache wants to put its pidfile into /run/apache2/httpd.pid, so dir needs to exist
&& mkdir -p /run/apache2 \
&& ln -sf /usr/bin/php7 /usr/bin/php \
&& ln -sf /dev/stdout /var/www/logs/access.log \
&& ln -sf /dev/stdout /var/www/logs/ssl_access.log \
&& ln -sf /dev/stderr /var/www/logs/error.log \
&& ln -sf /dev/stderr /var/www/logs/ssl_error.log \
&& sed -i 's/^\(\(DocumentRoot\|ServerAdmin\|ServerName\) .*\)$/#\1/g' /etc/apache2/conf.d/ssl.conf

CMD ["/from_host/apache-run.sh"]