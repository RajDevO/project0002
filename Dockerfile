FROM ubuntu:latest
LABEL "author"="Rajesh"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git -y
RUN apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /usr/local/tomcat/webapps/
VOLUME /var/log/apache2
EXPOSE 80
ADD target ./* /usr/local/tomcat/webapps/
COPY target ./* /usr/local/tomcat/webapps/

