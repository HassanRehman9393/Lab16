FROM httpd:2.4-alpine

# Copy configuration files
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY proxy-config.conf /usr/local/apache2/conf/extra/proxy-config.conf

# Create health check endpoint
RUN mkdir -p /usr/local/apache2/htdocs/health
RUN echo "OK" > /usr/local/apache2/htdocs/health/index.html

EXPOSE 80

CMD ["httpd-foreground"] 