FROM openjdk:8-jre

LABEL maintainer="maak.daniel@gmail.com"
LABEL version="0.0.1"
LABEL description="Docker image for JDownloader2"

RUN mkdir -p /opt/jdownloader2/
WORKDIR /opt/jdownloader2/

COPY JDownloader.jar ./
COPY run-jd2.sh ./
RUN java -Djava.awt.headless=true -jar JDownloader.jar

RUN chmod +x /opt/jdownloader2/run-jd2.sh
CMD ["run-jd2.sh"]