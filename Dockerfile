FROM openjdk:8-jre

LABEL maintainer="maak.daniel@gmail.com" \
        version="1.1.0" \
        description="Dockerimage for JDownloader2 in Headless mode"

# install unrar for rar archives
RUN apt-get update && apt-get install -y software-properties-common \
        && apt-add-repository non-free \ 
        && apt-get update && apt-get install -y unrar \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/jdownloader2/
COPY JDownloader.jar /opt/jdownloader2/JDownloader.jar
COPY run.sh /opt/jdownloader2/run.sh

# run jdownloader during the build process
# after the first run config directory /opt/jdownloader2/cfg is available
WORKDIR /opt/jdownloader2/
RUN mkdir -p /root/Downloads/ \
        && chmod +x run.sh
VOLUME [ "/root/Downloads" ]
VOLUME [ "/opt/jdownloader2/cfg" ]

RUN java -Djava.awt.headless=true -jar JDownloader.jar
CMD ["/bin/bash","run.sh"]