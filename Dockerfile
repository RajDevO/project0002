FROM jetty
ADD target/bookstore-example-1.0-SNAPSHOT.war /var/lib/jetty/webapps/root.war
EXPOSE 8090
CMD ["mvn jetty:run -Pproduction"]
