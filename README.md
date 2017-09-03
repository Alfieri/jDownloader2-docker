# jDownloader2-docker

#### Docker image for JDownloader2 running in headless mode

## Usage
1. Pull image from [Docker Hub](https://hub.docker.com/r/alfieri/jdownloader2) `docker pull alfieri/jdownloader2`.
2. Run container with download and config directory mapping `docker run -d --name jd -v <config directory>:/opt/jdownloader2/cfg -v <downloader directory>:/root/Downloads alfieri/jdownloader2`. 
    Just replace `config directory` and `downloader directory` with your local config and download path. During the start JDownloader will install all missing updates. If this happens the container stop automaticly (skip step 3.).
3. Stop container and adjust configuration `docker stop jd`
4. Set your MyJDownloader credentials to `org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json`. Set or create the following key:value pairs
        ``` "email" : "",
        "password" : "",
        "devicename" : ""
        ```
    * Note: Start JDownloader in graphic Mode on your local maschine. Adjust all settings and use the config directory (or all config files) for your docker instance.
5. Start the conatiner again `docker start jd`