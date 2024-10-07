FROM alpine:3.19

RUN apk update && apk add --no-cache	\
	curl								\
	mariadb-client						\
	php-fpm								\
	php-mysqli							\
	php									\
	php-curl							\
	php-phar							\
	php-mbstring

RUN mkdir -p /var/www/wordpress /run/php

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar	\
&& chmod +x /usr/local/bin/wp

RUN addgroup -S nginx && adduser -S nginx -G nginx

RUN sed -i 's/listen = 127.0.0.1:9000/listen = wordpress:9000/' /etc/php82/php-fpm.d/www.conf

EXPOSE 9000

COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm82", "-F"]
