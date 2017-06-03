FROM nimmis/alpine-apache-php7

# tips:
# https://hub.docker.com/_/php/
# https://gist.github.com/chadrien/c90927ec2d160ffea9c4
# https://hub.docker.com/r/nimmis/alpine-apache-php7/
# https://github.com/nimmis/docker-alpine-apache-php7/blob/master/Dockerfile
# https://gist.github.com/mikecrittenden/ebd48da243dc9b253da1726429d12b8f
# https://hub.docker.com/r/wodby/nginx-php-7-alpine/~/dockerfile/

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk update \
&& apk upgrade \
&& apk add php7-xdebug@testing \
&& rm -rf /var/cache/apk/* \

# Create symlinks PHP -> PHP7
&& ln -sf /usr/bin/php7 /usr/bin/php \

&& ln -sf /dev/stdout /var/log/apache2/access.log \
&& ln -sf /dev/stderr /var/log/apache2/error.log

COPY xdebug.ini /etc/php7/conf.d/xdebug.ini
COPY apache-run.sh /etc/sv/apache2/run

EXPOSE 80