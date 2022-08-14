FROM tomcat:jdk11-openjdk-slim-buster

LABEL "author"="Rajesh"

COPY target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]

