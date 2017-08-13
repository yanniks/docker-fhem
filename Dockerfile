FROM arm32v7/debian:jessie-slim

MAINTAINER michaelatdocker <michael.kunzmann@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
apt-get -y --force-yes --no-install-recommends install wget apt-transport-https

# Install perl packages
RUN apt-get -y --force-yes --no-install-recommends install libalgorithm-merge-perl \
libclass-isa-perl \
libcommon-sense-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libio-socket-ip-perl \
libio-socket-multicast-perl \
libjson-perl \
libjson-xs-perl \
libmail-sendmail-perl \
libsocket-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl \
libxml-simple-perl

RUN wget -qO - https://debian.fhem.de/archive.key | apt-key add -
RUN echo "deb https://debian.fhem.de/nightly/ /" | tee -a /etc/apt/sources.list.d/fhem.list && \
apt-get update && \
apt-get -y --force-yes install fhem telnet && \
apt-get clean -qy && \
rm -rf /var/lib/apt/lists/*

RUN echo Europe/Berlin > /etc/timezone && dpkg-reconfigure tzdata

COPY fhem-foreground /usr/bin/fhem-foreground

VOLUME ["/opt/fhem"]
EXPOSE 8083

CMD ["/usr/bin/fhem-foreground"]
