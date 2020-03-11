# Headless jDownloader2 Dockerimage

[![GitHub issues](https://img.shields.io/github/issues/Alfieri/jDownloader2-docker.svg)](https://github.com/Alfieri/jDownloader2-docker/issues)
[![GitHub license](https://img.shields.io/github/license/Alfieri/jDownloader2-docker.svg)](https://github.com/Alfieri/jDownloader2-docker/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Alfieri/jDownloader2-docker.svg?label=Github%20stars)](https://github.com/Alfieri/jDownloader2-docker/stargazers)

![docker build](https://img.shields.io/docker/cloud/automated/alfieri/jdownloader2.svg)
![docker build](https://img.shields.io/docker/cloud/build/alfieri/jdownloader2.svg)
![image size](https://img.shields.io/microbadger/image-size/alfieri/jdownloader2.svg)
![layers](https://img.shields.io/microbadger/layers/alfieri/jdownloader2.svg)
![docker pulls](https://img.shields.io/docker/pulls/alfieri/jdownloader2.svg)
![docker Stars](https://img.shields.io/docker/stars/alfieri/jdownloader2.svg)

Docker image for JDownloader2 running in headless mode

- [Headless jDownloader2 Dockerimage](#headless-jdownloader2-dockerimage)
  - [Supported Tags](#supported-tags)
  - [Versions](#versions)
    - [v2.x](#v2x)
    - [v1.x](#v1x)
  - [Environment Variables](#environment-variables)
  - [Usage](#usage)
    - [Docker CLI](#docker-cli)
    - [Docker Compose](#docker-compose)

## Supported Tags

- [2.0.1](https://github.com/Alfieri/jDownloader2-docker/blob/2.0.1/Dockerfile), [2.0](https://github.com/Alfieri/jDownloader2-docker/blob/2.0.1/Dockerfile), [latest](https://github.com/Alfieri/jDownloader2-docker/blob/2.0.1/Dockerfile)

- [1.4.1](https://github.com/Alfieri/jDownloader2-docker/blob/1.4/Dockerfile), [1.4](https://github.com/Alfieri/jDownloader2-docker/blob/1.4/Dockerfile) - Dockerfile is not up to date; the volume path is not correct but fixed already fixed in this version

## Versions

If you do not care about image size then use the latest version or any version from 2.x. For my opinion the version 2.x is a little bit faster then version one because of performance improvements from openjdk 8 to 11. But since OpenJDK 10 they do not provide an image with just the Java runtime, you always get the complete SDK.

### v2.x

- based on OpenJDK 11 slim image

### v1.x

- based on OpenJDK 8 JRE slim image

## Environment Variables

The all the files mapped in the volumes are stored with UID 1000 and GID 100. You can configure this if needed by setting the follwing two environment variables. During the container start all files from mapped volumes will be changed to the default UID/GID or passed JUID/JGID.

| Env variable |      Description       |
| :----------: | :--------------------: |
|     JUID     | User ID for all files  |
|     JGID     | Group ID for all files |

## Usage

Note: you do not need the `--restart` flag because the container will run a endless loop so it does not stop. But if you want the container start at system start up just pass `--restart always`
  
Hint: Start JDownloader in graphic Mode on your local maschine. Adjust all settings and use the config directory (or all config files) for your docker instance.

### Docker CLI

1. Pull image from [Docker Hub](https://hub.docker.com/r/alfieri/jdownloader2) `docker pull alfieri/jdownloader2:latest`.
2. Run container with download and config directory mapping `docker run -d --name jd -v <config directory>:/opt/jdownloader2/cfg -v <downloader directory>:/home/jdownloader/Downloads alfieri/jdownloader2:latest`. 
    Just replace `config directory` and `downloader directory` with your local config and download path. During the start JDownloader will install all missing updates. If this happens the container stop automaticly (skip step 3.).
3. Stop container and adjust configuration `docker stop jd`
4. Set your MyJDownloader credentials to `org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json` (you will find a empty file in my git repo). Set or create the following key:value pairs

```json
{
  "email" : "",
  "password" : "",
  "devicename" : ""
}
```

5. Start the conatiner again `docker start jd`

### Docker Compose

(see docker-compose.yml in my git repo)

```dockerfile
version: "3.4"

services:
  jd2:
    image: alfieri/jdownloader2:latest
    container_name: jd2
    restart: always
    volumes:
      - "<your config path here>:/opt/jdownloader2/cfg"
      - "<your download path here>:/home/jdownloader/Downloads"
```
