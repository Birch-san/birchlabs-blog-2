#!/bin/sh
# forked from Apache httpd's Alpine Dockerfile
# https://github.com/docker-library/httpd/blob/master/2.4/alpine/httpd-foreground
set -e

mkdir -p /run/apache2

# Apache gets grumpy about PID files pre-existing
rm -f /run/apache2/httpd.pid

exec httpd -DFOREGROUND