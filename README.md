# Linshare UI-Upload-Request

#### How to build the image

```bash
$ docker build --build-arg VERSION="LATEST" --build-arg CHANNEL="releases" --build-arg EXT="com" -t linagora/linshare-ui-upload-request:latest .
```

#### How to run the container

For now SSL encryption is mandatory.

```bash
$ docker run -d \
-v $PWD/ca.pem:/usr/local/apache2/conf/server-ca.crt \
-v $PWD/localhost.pem:/usr/local/apache2/conf/server.crt \
-v $PWD/localhost.key:/usr/local/apache2/conf/server.key \
-e EXTERNAL_URL=<wanted_FQDN> \
-e BASE_URL=linshare \
-e TOMCAT_URL=<tomcat-ip> \
-e TOMCAT_PORT=<tomcat-port>
-p 443:443 \
linagora/linshare-ui-upload-request
```
