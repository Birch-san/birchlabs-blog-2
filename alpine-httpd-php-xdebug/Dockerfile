FROM alpine:3.6

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk add --no-cache apache2 php7 php7-apache2 php7-xdebug@testing

COPY from_host /from_host

# Create symlinks PHP -> PHP7
RUN mv /from_host/xdebug.ini /etc/php7/conf.d/xdebug.ini \
&& ln -sf /usr/bin/php7 /usr/bin/php \
&& ln -sf /dev/stdout /var/www/logs/access.log \
&& ln -sf /dev/stderr /var/www/logs/error.log \
# Apache wants to put its pidfile into /run/apache2/httpd.pid, so dir needs to exist
&& mkdir -p /run/apache2 \
&& sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf \
&& sed -i 's/^#\(LoadModule rewrite_module.*\)/\1/g' /etc/apache2/httpd.conf \
&& sed -i 's/^#\(LoadModule http2_module.*\)/\1/g' /etc/apache2/httpd.conf \
&& sed -i 's/AllowOverride [Nn]one/AllowOverride All/g' /etc/apache2/httpd.conf \
&& echo 'Protocols h2 http/1.1' >> /etc/apache2/httpd.conf

EXPOSE 80

CMD ["/from_host/apache-run.sh"]