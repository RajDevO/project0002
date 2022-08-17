FROM tomcat:8.5.5-jre8

LABEL maintainer="Rajesh"

COPY /var/lib/jenkins/workspace/project0002/target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 8080

WORKDIR /usr/local/tomcat
