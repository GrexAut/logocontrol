FROM debian:buster

COPY content/logocontrol-pi-0.5.2.tgz /tmp/
COPY content/run.sh /opt/

RUN tar xvzf /tmp/logocontrol-pi-0.5.2.tgz -C /opt/ && rm /opt/LogoControl/libnodave-arm.so && sed -i -e 's/\-arm.so/.so/g' /opt/LogoControl/LogoControl.exe.config

RUN dpkg --add-architecture i386

RUN export DEBIAN_FRONTEND=noninteractive \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y git make gcc mono-complete nginx apache2-utils


RUN git clone https://github.com/netdata-be/libnodave.git /tmp/libnodave && cd /tmp/libnodave && make && make install
RUN cp /usr/lib/libnodave.so /opt/LogoControl/

COPY content/config.xml /opt/LogoControl/data/
RUN mkdir -p /opt/LogoControl/data && ln -s /opt/LogoControl/data/config.xml /opt/LogoControl/config.xml

EXPOSE 80


ENTRYPOINT ["/opt/run.sh"]

