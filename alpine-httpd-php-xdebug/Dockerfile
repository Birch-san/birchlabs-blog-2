FROM alpine:3.6

# hint:
# https://svn.apache.org/repos/asf/httpd/test/mod_h2/trunk/conf/sites/test2.example.org.conf

EXPOSE 80

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
&& apk add --no-cache \
apache2 \
apache2-http2 \
php7 \
php7-apache2 \
php7-xdebug@testing \
# remove bash if you want an even lighter image
bash

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
&& sed -i 's/AllowOverride [Nn]one/AllowOverride All/g' /etc/apache2/httpd.conf \
# h2c for an HTTP server, h2 for an HTTPS server
&& echo 'Protocols h2c http/1.1' >> /etc/apache2/httpd.conf \

# H2Direct confers zero-overhead feature negotiation
# https://icing.github.io/mod_h2/howto.html
# https://httpd.apache.org/docs/2.4/mod/mod_http2.html#h2direct
&& echo 'H2Direct on' >> /etc/apache2/httpd.conf \

# PUSH resources announced with H2PushResource will trigger an interim 103 response carrying Link headers (to give preload advice)
# https://httpd.apache.org/docs/2.4/mod/mod_http2.html#h2earlyhints
&& echo 'H2EarlyHints on' >> /etc/apache2/httpd.conf

CMD ["/from_host/apache-run.sh"]