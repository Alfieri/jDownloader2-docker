FROM openjdk:8-jre

LABEL maintainer="maak.daniel@gmail.com"
LABEL version="0.0.3"
LABEL description="Docker image for JDownloader2"

# create root download directory
RUN mkdir -p /root/Downloads/
# create directory for jdownloader2
RUN mkdir -p /opt/jdownloader2/
WORKDIR /opt/jdownloader2/

COPY JDownloader.jar ./

# run jdownloader during the build process
# after the first run config directory /opt/jdownloader2/cfg is available
RUN java -Djava.awt.headless=true -jar JDownloader.jar

CMD ["java","-Djava.awt.headless=true","-jar", "JDownloader.jar"]
