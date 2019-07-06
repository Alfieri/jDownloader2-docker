FROM openjdk:8-jre-slim

LABEL maintainer="maak.daniel@gmail.com" \
        version="1.2.0" \
        description="Dockerimage for JDownloader2 in Headless mode"

# install unrar for rar archives
RUN sed -i "s#deb http://deb.debian.org/debian stretch main#deb http://deb.debian.org/debian stretch main non-free#g" /etc/apt/sources.list \
        && sed -i "s#deb http://deb.debian.org/debian stretch-updates main#deb http://deb.debian.org/debian stretch-updates main non-free#g" /etc/apt/sources.list \
        && apt-get update && apt-get install -qy unrar 

WORKDIR /opt/jdownloader2/
COPY JDownloader.jar .
COPY run.sh .
RUN mkdir -p /root/Downloads/ \
        && chmod +x run.sh
        
VOLUME [ "/root/Downloads" ]
VOLUME [ "/opt/jdownloader2/cfg" ]

RUN java -Djava.awt.headless=true -jar JDownloader.jar
CMD ["/bin/bash","run.sh"]