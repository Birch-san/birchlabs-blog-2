FROM alpine:3.6

EXPOSE 80 443

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

RUN mv /from_host/xdebug.ini /etc/php7/conf.d/xdebug.ini \
&& mv /from_host/httpd.conf /etc/apache2/ \

# Apache wants to put its pidfile into /run/apache2/httpd.pid, so dir needs to exist
&& mkdir -p /run/apache2 \

# Create symlinks PHP -> PHP7
&& ln -sf /usr/bin/php7 /usr/bin/php \

# redirect Apache logs to our Docker output
&& ln -sf /dev/stdout /var/www/logs/access.log \
&& ln -sf /dev/stderr /var/www/logs/error.log \

# comment out VirtualHost section of /etc/apache2/conf.d/ssl.conf so that it doesn't clash with the one in our httpd.conf
&& echo "$(awk '/^<VirtualHost/{f=2} /^<\/VirtualHost/{f=1} f{$0 = "# " $0} f==1{f--} {print}' /etc/apache2/conf.d/ssl.conf)" > /etc/apache2/conf.d/ssl.conf

CMD ["/from_host/apache-run.sh"]