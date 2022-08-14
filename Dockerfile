FROM tomcat:8.0-alpine

LABEL "author"="Rajesh"

ADD target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [“/usr/local/tomcat/bin/catalina.sh”, “run”]
