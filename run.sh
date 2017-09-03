#!/bin/bash

while true; do
    if [ -f JDownloader.pid ]
    then
        sleep 15m
    else
        java -Djava.awt.headless=true -jar JDownloader.jar &
        sleep 30s
    fi
done
