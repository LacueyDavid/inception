FROM alpine:3.19

RUN apk update
RUN apk add	nginx \
		openssl

# creation du dossier ssl (Secure Sockets Layer) pour nginx
RUN mkdir -p /etc/nginx/ssl

# generation des clefs SSL
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=dlacuey.42.fr/UID=dlacuey"

# copie le fichier de config dans le container
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
