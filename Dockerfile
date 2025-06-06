FROM httpd:2.4

MAINTAINER LinShare <linshare@linagora.com>

ARG VERSION="6.4.1"
ARG CHANNEL="releases"

ENV LINSHARE_VERSION=$VERSION
ENV LS_SECURE_COOKIE=TRUE
ENV BASE_URL=linshare

RUN apt-get update && apt-get install wget bzip2 -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN URL="https://nexus.linagora.com/service/local/artifact/maven/content?r=linshare-${CHANNEL}&g=org.linagora.linshare&a=linshare-ui-upload-request&v=${VERSION}"; \
wget --no-check-certificate --progress=bar:force:noscroll \
 -O ui-upload-request.tar.bz2 "${URL}&p=tar.bz2" && \
wget --no-check-certificate --progress=bar:force:noscroll \
 -O ui-upload-request.tar.bz2.sha1 "${URL}&p=tar.bz2.sha1" && \
sed -i 's#^\(.*\)#\1\tui-upload-request.tar.bz2#' ui-upload-request.tar.bz2.sha1 && \
sha1sum -c ui-upload-request.tar.bz2.sha1 --quiet && rm -f ui-upload-request.tar.bz2.sha1

RUN tar -jxf ui-upload-request.tar.bz2 -C /usr/local/apache2/htdocs && \
chown -R www-data /usr/local/apache2/htdocs/linshare-ui-upload-request && \
rm -f ui-upload-request.tar.bz2

COPY ./httpd.extra.conf /usr/local/apache2/conf/extra/httpd.extra.conf
RUN cat /usr/local/apache2/conf/extra/httpd.extra.conf >> /usr/local/apache2/conf/httpd.conf

COPY ./linshare-ui-upload-request.conf /usr/local/apache2/conf/extra/linshare-ui-upload-request.conf

EXPOSE 80