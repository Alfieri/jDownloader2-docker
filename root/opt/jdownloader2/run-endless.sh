#!/bin/bash
JAVA=/usr/local/openjdk-11/bin/java

JUID=${JUID:-1000}
JGID=${JGID:-100}

groupmod -o -g "$JGID" jdownloader
usermod -o -u "$JUID" jdownloader

echo "
-----
User uid:    $(id -u jdownloader)
User gid:    $(id -g jdownloader)
-----
"

chown -R $JUID:$JGID /home/jdownloader/Downloads
chown -R $JUID:$JGID /opt/jdownloader2

sudo -u jdownloader $JAVA -Djava.awt.headless=true -jar JDownloader.jar &
sleep 10s

while true; do
    if [ -f JDownloader.pid ]
    then
        sleep 2m
    else
        sudo -u jdownloader $JAVA -Djava.awt.headless=true -jar JDownloader.jar &
        sleep 30s
    fi
done
