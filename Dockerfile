FROM alpine

MAINTAINER Yannik Ehlert <kontakt@yanniks.de>

RUN apk add --no-cache perl perl-device-serialport perl-xml-libxml-simple \
perl-libwww perl-soap-lite perl-xml-parser && \
adduser -S -D -h /opt/fhem -G dialout fhem && \
cd /opt/fhem && \
wget http://fhem.de/fhem-5.8.tar.gz && \
tar -xzf fhem-5.8.tar.gz -C /tmp/ && \
rm fhem-5.8.tar.gz && \
cp -R /tmp/fhem-5.8/* ./ && \
rm -r /tmp/fhem-5.8/

COPY fhem-foreground /usr/bin/fhem-foreground

VOLUME ["/opt/fhem"]
EXPOSE 8083

USER fhem:dialout
CMD ["/usr/bin/fhem-foreground"]
