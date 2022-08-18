FROM ubuntu:latest
LABEL "author"="Rajesh"
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN apt install jetty9
RUN systemctl start jetty9
RUN systemctl restart jetty9
ADD target/* /var/lib/jetty/webapps/
CMD ["mvn jetty:run -Pproduction"]
