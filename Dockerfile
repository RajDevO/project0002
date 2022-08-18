FROM jetty
ENTRYPOINT ["/entrypoint.sh"]
ADD target/* /var/lib/jetty/webapps/
EXPOSE 8888
CMD ["mvn jetty:run -Pproduction"]

