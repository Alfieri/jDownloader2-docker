FROM openjdk:8-jre-slim

ARG VERSION="1.3"

LABEL maintainer="maak.daniel@gmail.com" \
        version=${VERSION}} \
        description="Dockerimage for JDownloader2 in Headless mode"

###-----
# install unrar
###-----
RUN sed -i "s#deb http://deb.debian.org/debian stretch main#deb http://deb.debian.org/debian stretch main non-free#g" /etc/apt/sources.list \
        && sed -i "s#deb http://deb.debian.org/debian stretch-updates main#deb http://deb.debian.org/debian stretch-updates main non-free#g" /etc/apt/sources.list \
        && apt-get update \ 
        && apt-get install -qy unrar \
        && rm -rf /var/lib/apt/lists/*

###-----
# create user for JDownloader2 to handle file permission
###-----
ARG DEFAULT_UID="1000"
ARG DEFAULT_GID="100"
RUN useradd -u ${DEFAULT_UID} -g ${DEFAULT_GID} -s /bin/false jdownloader \
        && mkdir -p /home/jdownloader/Downloads \
        && chown ${DEFAULT_UID}:${DEFAULT_GID} /home/jdownloader/Downloads

###-----
# install JDownloader2
###-----
WORKDIR /opt/jdownloader2/
ADD http://installer.jdownloader.org/JDownloader.jar .
RUN java -Djava.awt.headless=true -jar JDownloader.jar
COPY root/ /
RUN chmod +x change-user.sh run-endless.sh

###-----
# Run
###-----
VOLUME [ "/home/jdownloaders/Downloads" ]
VOLUME [ "/opt/jdownloader2/cfg" ]
RUN chown -R jdownloader:100 /opt/jdownloader2
USER jdownloader
CMD ["/bin/bash","run-endless.sh"]