FROM centos

MAINTAINER Rajesh

RUN curl -OL ftp://fr2.rpmfind.net/linux/centos/6.6/os/x86_64/Packages/unzip-6.0-1.el6.x86_64.rpm
RUN yum install -y unzip-6.0-1.el6.x86_64.rpm
RUN rm unzip-6.0-1.el6.x86_64.rpm

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz
RUN tar xvzf apache*.tar.gz
RUN mv apache-tomcat-8.5.40/* /opt/tomcat/.
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN target/bookstore-example-1.0-SNAPSHOT.war /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
