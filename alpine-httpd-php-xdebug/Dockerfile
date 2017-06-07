FROM alpine:edge

# tips:
# https://github.com/codecasts/php-alpine
# https://hub.docker.com/r/j33f/alpine-apache-php7/~/dockerfile/

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk --update upgrade \
&& apk add apache2 php7 php7-apache2 php7-xdebug@testing \
&& rm -rf /var/cache/apk/* \

# Create symlinks PHP -> PHP7
&& ln -sf /usr/bin/php7 /usr/bin/php

RUN sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf \
&& sed -i 's/^#\(LoadModule rewrite_module.*\)/\1/g' /etc/apache2/httpd.conf \
&& sed -i 's/AllowOverride [Nn]one/AllowOverride All/' /etc/apache2/httpd.conf

COPY xdebug.ini /etc/php7/conf.d/xdebug.ini
COPY httpd-foreground.sh /usr/local/bin/httpd-foreground

EXPOSE 80

CMD ["httpd-foreground"]