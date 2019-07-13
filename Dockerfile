FROM openjdk:11-slim

ARG VERSION="2.0.1"
LABEL maintainer="maak.daniel@gmail.com" \
        version=${VERSION}} \
        description="Dockerimage for JDownloader2 in Headless mode"

###-----
# install unrar
###-----
RUN sed -i "s#deb http://deb.debian.org/debian stretch main#deb http://deb.debian.org/debian stretch main non-free#g" /etc/apt/sources.list \
        && sed -i "s#deb http://deb.debian.org/debian stretch-updates main#deb http://deb.debian.org/debian stretch-updates main non-free#g" /etc/apt/sources.list \
        && apt-get update \ 
        && apt-get install -qy unrar sudo \
        && rm -rf /var/lib/apt/lists/*

###-----
# create user for JDownloader2 to handle file permission
###-----
ARG DEFAULT_UID="1000"
ARG DEFAULT_GID="100"
RUN groupmod --new-name jdownloader users \
        && useradd -u ${DEFAULT_UID} -g ${DEFAULT_GID} -s /bin/false jdownloader \
        && mkdir -p /home/jdownloader/Downloads \
        && chown ${DEFAULT_UID}:${DEFAULT_GID} /home/jdownloader/Downloads

###-----
# install JDownloader2
###-----
WORKDIR /opt/jdownloader2/
ADD http://installer.jdownloader.org/JDownloader.jar .
COPY root/ /
RUN chmod +x run-endless.sh \
        && mkdir cfg

###-----
# Run
###-----
VOLUME [ "/home/jdownloader/Downloads" ]
VOLUME [ "/opt/jdownloader2/cfg" ]
RUN chown -R jdownloader:jdownloader /opt/jdownloader2
CMD ["/bin/bash","run-endless.sh"]