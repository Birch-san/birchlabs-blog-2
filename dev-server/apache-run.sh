#!/bin/sh

# forked from Kjell Havnesköld's nimmis/alpine-apache-php7:
# https://github.com/nimmis/docker-alpine-apache/blob/master/root/etc/sv/apache2/run

set -e
export APACHE_RUN_USER=apache
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/web/run/apache2.pid
export APACHE_RUN_DIR=/var/run/
export APACHE_LOCK_DIR=/var/lock/
export APACHE_LOG_DIR=/web/log/

export LANG=C
export LANG

# consult Docker environment variables
source /etc/envvars

exec /usr/sbin/httpd -DNO_DETACH -f /web/config/httpd.conf