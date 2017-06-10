FROM alpine:3.6

# tips:
# https://github.com/codecasts/php-alpine
# https://wiki.alpinelinux.org/wiki/Setting_Up_Apache_with_PHP
# https://secure.php.net/manual/en/install.unix.apache2.php
# https://github.com/wichon/alpine-apache-php/blob/master/Dockerfile
# https://github.com/j33f/alpine-apache-php7/blob/master/Dockerfile
# https://github.com/codecasts/php-alpine
# https://php-alpine.codecasts.rocks/
# https://stackoverflow.com/a/6162594/5257399 libapache2-mod-php5
# https://stackoverflow.com/a/41313564/5257399

COPY xdebug.ini /etc/php7/conf.d/xdebug.ini
COPY apache-run.sh /

# https://github.com/jessfraz/dockerfiles/commit/7ac4881609d29b8f4ebb824b85369d61c0f34a41
RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
# installing php7-apache2 gives you apache2, under /etc/apache2
&& apk add --no-cache apache2 php7 php7-apache2 php7-xdebug@testing
# && rm -rf /var/cache/apk/* \

# Create symlinks PHP -> PHP7
RUN ln -sf /usr/bin/php7 /usr/bin/php \
&& ln -sf /dev/stdout /var/www/logs/access.log \
&& ln -sf /dev/stderr /var/www/logs/error.log \
# Apache wants to put its pidfile into /run/apache2/httpd.pid, so dir needs to exist
&& mkdir -p /run/apache2 \
&& sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf \
&& sed -i 's/^#\(LoadModule rewrite_module.*\)/\1/g' /etc/apache2/httpd.conf \
&& sed -i 's/AllowOverride [Nn]one/AllowOverride All/g' /etc/apache2/httpd.conf

# https://github.com/gliderlabs/docker-alpine/issues/183
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_Init_System
# https://wiki.alpinelinux.org/wiki/Apache
# RUN rc-update add apache2

# apk info -a php7-apache2
# find / -name 'mod_php7.so'
# !! attention! here's where 
# /usr/lib/apache2/mod_php7.so

# php7-apache2-7.1.5-r0 depends on:
# php7-common
# apache2 

EXPOSE 80

# WORKDIR /
CMD ["/apache-run.sh"]