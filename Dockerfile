FROM ubuntu:latest
LABEL "author"="Rajesh"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git -y
RUN apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /usr/local/tomcat/webapps/
VOLUME /var/log/apache2
EXPOSE 80
ADD target/* /usr/local/tomcat/webapps/
#COPY target/* /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]







#FROM tomcat:8.0.51
#ADD target/* /usr/local/tomcat/webapps/
#CMD ["catalina.sh","run"]







#FROM ubuntu:latest
#MAINTAINER Rajesh
#RUN apt-get update && apt-get install -y && apt-get install -y wget && apt-get install openjdk-8-jdk -y && rm -rf /var/lib/apt/lists/*
#RUN apt-get install tar
#RUN mkdir /opt/tomcat/
#WORKDIR /opt/tomcat
#RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
#RUN ls -l
#RUN tar xzvf apache-tomcat-9.0.65.tar.gz -C /opt/tomcat
#RUN mv apache-tomcat-9.0.65/* /opt/tomcat/.
#RUN java -version
#WORKDIR /opt/tomcat/webapps
#ADD target/* /opt/tomcat/webapps/
#EXPOSE 80
#CMD ["/opt/tomcat/bin/catalina.sh", "run"]

