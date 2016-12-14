FROM java:openjdk-8-jre-alpine

MAINTAINER Franck Cuny <franck.cuny@gmail.com>

LABEL name="distributedlog" version="0.3.51"

RUN apk add --no-cache wget bash \
    && mkdir -p /opt \
    && cd /opt \
    && wget -q https://github.com/twitter/distributedlog/releases/download/0.3.51-RC0/distributedlog-service-63d214d3a739cb58a71a8b51127f165d15f00584.zip \
    && unzip distributedlog-service-63d214d3a739cb58a71a8b51127f165d15f00584.zip \
    && mv distributedlog-service/ distributedlog/ \
    && rm -rf distributedlog/conf

WORKDIR /opt/distributedlog

COPY bin/write-proxy-start.sh /usr/local/bin/
COPY conf /opt/distributedlog/conf

RUN ["chmod", "+x", "/usr/local/bin/write-proxy-start.sh"]

EXPOSE 8000/tcp

CMD ["/usr/local/bin/write-proxy-start.sh"]
