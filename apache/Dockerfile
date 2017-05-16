FROM httpd:2.4

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim wget subversion libapache2-mod-perl2 libapache2-svn && \
#    a2enmod proxy proxy_http dav dav_svn && \
    mkdir Apache && \
    cd Apache && \
    wget https://raw.githubusercontent.com/opf/openproject/v6.1.5/extra/Apache/OpenProjectAuthentication.pm && \
    cd - && \
    chmod -R go+rwX Apache && \
    sed -i 's/Listen\ 80/Listen\ 8080/g' /usr/local/apache2/conf/httpd.conf && \
    chmod -R go+rwX /usr/local/apache2
RUN echo "Include conf.d/*.conf" >> conf/httpd.conf && \
    mkdir conf.d
COPY repos.conf conf.d/
EXPOSE 8080
USER 1001
