FROM alpine:3.4

ENV VARNISHSRC=/usr/include/varnish VMODDIR=/usr/lib/varnish/vmods

RUN apk --update add varnish curl jq && \
  rm -rf /var/cache/apk/*

ADD default.vcl /etc/varnish/default.vcl
ADD start.sh /start.sh

RUN chmod +x /start.sh
EXPOSE 80
CMD ["/start.sh"]
