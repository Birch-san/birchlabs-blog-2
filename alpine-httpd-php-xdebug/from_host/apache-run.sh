#!/bin/sh
# forked from Apache httpd's Alpine Dockerfile
# https://github.com/docker-library/httpd/blob/master/2.4/alpine/httpd-foreground
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /run/apache2/httpd.pid

php-fpm7 -y /etc/php7/php-fpm.conf -c /etc/php7/php.ini
exec httpd -DFOREGROUND