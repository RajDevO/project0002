FROM ubuntu:latest
LABEL "author"="Rajesh"
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd /opt 
RUN wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.14.v20181114/jetty-distribution-9.4.14.v20181114.zip
RUN unzip jetty-distribution-9.4.14.v20181114.zip
RUN mv jetty-distribution-9.4.14.v20181114/ jetty9
RUN useradd -m jetty9
RUN chown -R jetty9:jetty9 /opt/jetty9/
RUN systemctl start jetty9
RUN systemctl restart jetty9
ADD target/* /var/lib/jetty/webapps/
CMD ["mvn jetty:run -Pproduction"]
