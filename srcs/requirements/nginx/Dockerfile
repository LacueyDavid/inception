FROM alpine:3.19

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes				\
	-days 365 -newkey rsa:2048				\
	-keyout /etc/nginx/ssl/inception.key	\
	-out /etc/nginx/ssl/inception.crt		\
	-subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=dlacuey.42.fr/UID=dlacuey"


COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
