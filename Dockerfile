FROM ubuntu:latest-tomcat:8.5.47-jdk8-openjdk
LABEL "author"="Rajesh"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git -y
RUN apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /var/www/html
VOLUME /var/log/apache2
EXPOSE 80
ADD target ./* /var/www/html/
COPY target ./* /var/www/html/
