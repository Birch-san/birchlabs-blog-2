FROM alpine:3.7

EXPOSE 80 443

RUN apk add --no-cache \
apache2 \
apache2-http2 \
apache2-ssl \
# for FastCGI PHP, required by Apache's mpm_event (which is required by HTTP/2)
apache2-proxy \
php7-fpm \
php7-xdebug \
# remove bash if you want an even lighter image
bash

COPY from_host /from_host

RUN mv /from_host/xdebug.ini /etc/php7/conf.d/xdebug.ini \
&& mv /from_host/httpd.conf /etc/apache2/ \

# Apache wants to put its pidfile into /run/apache2/httpd.pid, so dir needs to exist
&& mkdir -p /run/apache2 /var/log/php7 \

# Create symlinks PHP -> PHP7
&& ln -sf /usr/bin/php7 /usr/bin/php \

# redirect Apache logs to our Docker output
&& ln -sf /dev/stdout /var/www/logs/access.log \
&& ln -sf /dev/stderr /var/www/logs/error.log \

# PHP FPM 7 logs
&& ln -sf /dev/stderr /var/log/php7/error.log \

&& echo "LoadModule slotmem_shm_module modules/mod_slotmem_shm.so" >> /etc/apache2/conf.d/slotmem_shm.conf \

# comment out VirtualHost section of /etc/apache2/conf.d/ssl.conf so that it doesn't clash with the one in our httpd.conf
&& echo "$(awk '/^<VirtualHost/{f=2} /^<\/VirtualHost/{f=1} f{$0 = "# " $0} f==1{f--} {print}' /etc/apache2/conf.d/ssl.conf)" > /etc/apache2/conf.d/ssl.conf

CMD ["/from_host/apache-run.sh"]