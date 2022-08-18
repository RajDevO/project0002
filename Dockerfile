FROM ubuntu:latest
LABEL "author"="Rajesh"
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ADD target/* /var/lib/jetty/webapps/
CMD ["mvn jetty:run -Pproduction"]
