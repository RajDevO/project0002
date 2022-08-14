FROM tomcat

COPY /target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 80
