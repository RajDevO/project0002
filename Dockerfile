FROM ubuntu:latest
LABEL "author"="Rajesh"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git -y
RUN apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /var/www/html
VOLUME /var/log/apache2
EXPOSE 80
ADD /var/lib/jenkins/workspace/project0002/target/bookstore-example-1.0-SNAPSHOT.war /var/www/html
#COPY /var/lib/jenkins/workspace/project0002/target/bookstore-example-1.0-SNAPSHOT.war /var/www/html
