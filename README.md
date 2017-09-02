# jDownloader2-docker

#### Docker image for JDownloader2 running in headless mode

## Usage
1. Pull image from [Docker Hub](https://hub.docker.com/r/alfieri/jdownloader2) `docker pull alfieri/jdownloader2`.
2. Run container `docker run -d --name jd -v <config directory>:/opt/jdownloader2/cfg -v <downloader directory>:/root/Downloads alfieri/jdownloader2`. 
    Just replace `config directory` and `downloader directory` with your local config and download path.
3. Stop container and adjust configuration `docker stop jd`
4. Set your MyJDownloader credentials to `org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json`. <br>
        ``` "email" : "",
        "password" : "",
        "devicename" : ""
        ```
5. Start the conatiner again `docker start jd`
6. Finish your configuration on [MyJDownloader.org](https://my.jdownloader.org/)