FROM alpine-httpd-php-xdebug

# tips:
# https://github.com/faisyl/alpine-runit

RUN apk --update upgrade \
&& apk add runit \
&& rm -rf /var/cache/apk/*

ADD start-runit.sh /sbin/start_runit

EXPOSE 80

CMD ["/sbin/start_runit"]