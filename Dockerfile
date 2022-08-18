FROM jetty
ADD target/bookstore-example-1.0-SNAPSHOT.war /var/lib/jetty/webapps/
EXPOSE 8888
CMD ["mvn jetty:run -Pproduction"]

