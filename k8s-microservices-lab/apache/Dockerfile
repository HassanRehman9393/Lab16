FROM httpd:2.4-alpine

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY proxy-config.conf /usr/local/apache2/conf/extra/proxy-config.conf

RUN mkdir -p /usr/local/apache2/htdocs/health
RUN echo "OK" > /usr/local/apache2/htdocs/health/index.html

EXPOSE 80 