FROM tomcat:7

ADD target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
