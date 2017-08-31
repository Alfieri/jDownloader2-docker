#!/bin/bash

JDPID=$(cat JDownloader.pid)
kill $JDPID
wait $JDPID

java -Djava.awt.headless=true -jar JDownloader.jar &

while true; do sleep inf done;
