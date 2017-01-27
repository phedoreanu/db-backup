FROM influxdb:alpine

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	openssh \
	mongodb-tools

COPY id_rsa_test /id_rsa_test
RUN chmod 400 /id_rsa_test

COPY crontab.txt /crontab.txt
COPY dump_db.sh /dump_db.sh
COPY entrypoint.sh /entrypoint.sh

RUN /usr/bin/crontab /crontab.txt
ENTRYPOINT ["/entrypoint.sh"]
