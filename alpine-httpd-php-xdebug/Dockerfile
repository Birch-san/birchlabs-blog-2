FROM httpd:2.4-alpine

# tips:
# https://github.com/codecasts/php-alpine

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk --update upgrade \
&& apk add php7 php7-apache2 php7-xdebug@testing runit \
&& rm -rf /var/cache/apk/* \

# Create symlinks PHP -> PHP7
&& ln -sf /usr/bin/php7 /usr/bin/php \

&& sed -i 's/^#ServerName.*/ServerName localhost/' /usr/local/apache2/conf/httpd.conf \
&& sed -i 's/^#\(LoadModule rewrite_module.*\)/\1/g' /usr/local/apache2/conf/httpd.conf \
&& sed -i 's/AllowOverride [Nn]one/AllowOverride All/' /usr/local/apache2/conf/httpd.conf

COPY xdebug.ini /etc/php7/conf.d/xdebug.ini

EXPOSE 80