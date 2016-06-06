FROM alpine:3.3
MAINTAINER Florian Bertholin <fb@heetch.com>

RUN apk add --update rsyslog rsyslog-tls && rm -rf /var/cache/apk/*

ADD run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
ADD rsyslog.conf /etc/
ADD logmatic.crt /etc/rsyslog.d/keys/ca.d/

EXPOSE 514
EXPOSE 514/udp

CMD ["/tmp/run.sh"]
