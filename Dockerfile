FROM openjdk:7-alpine
RUN mkdir /oc4j
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV ORACLE_HOME=/oc4j
#ENV DS_CONFIG_URL=''
#ENV BITS_APP_URL=''
#ENV OC4J_ADMIN_PASSWORD=''
COPY oc4j_extended_101350.zip /oc4j/oc4j.zip
COPY run.sh /run.sh
RUN apk add -U ttf-dejavu && \
    cd oc4j && \
    unzip oc4j.zip && \
    rm oc4j.zip
COPY oc4j/config/system-jazn-data.xml /oc4j/j2ee/home/config/system-jazn-data.xml
COPY oc4j/config/jms.xml /oc4j/j2ee/home/config/jms.xml
#COPY oc4j/config/server.xml /oc4j/j2ee/home/config/server.xml
#COPY oc4j/config/default-web-site.xml /oc4j/j2ee/home/config/default-web-site.xml
#COPY oc4j/config/bits /oc4j/j2ee/home/config/bits
EXPOSE 8888
VOLUME /oc4j
WORKDIR /oc4j
CMD ["/run.sh"]
