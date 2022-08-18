FROM jetty:9.3-jre8
ADD target/bookstore-example-1.0-SNAPSHOT.war /opt
RUN apt-get update -y
COPY target/bookstore-example-1.0-SNAPSHOT.war /var/lib/jetty/webapps/ROOT.war
CMD ["mvn jetty:run -Pproduction"]
     
