FROM nimmis/java-centos:oracle-7-jdk
#FROM anapsix/alpine-java:7_jdk
RUN mkdir /oc4j
#ENV JAVA_HOME=/opt/jdk
ENV JAVA_HOME=/usr/java/default
ENV ORACLE_HOME=/oc4j
#ENV DS_CONFIG_URL=''
#ENV BITS_APP_URL=''
#ENV OC4J_ADMIN_PASSWORD=''
COPY oc4j_extended_101350.zip /oc4j/oc4j.zip
COPY run.sh /run.sh
RUN yum install -y unzip && \
    cd /oc4j && \
    unzip oc4j.zip && \
    rm oc4j.zip
#RUN apk add -U ttf-dejavu fontconfig && \
#    cd oc4j && \
#    unzip oc4j.zip && \
#    rm oc4j.zip
COPY oc4j/config/system-jazn-data.xml /oc4j/j2ee/home/config/system-jazn-data.xml
COPY oc4j/config/jms.xml /oc4j/j2ee/home/config/jms.xml
COPY oc4j/config/data-sources.xml /oc4j/j2ee/home/config/data-sources.xml
COPY oc4j/applications/bits.ear /oc4j/j2ee/home/bits.ear
COPY oc4j/applications/bits.ear /oc4j/j2ee/home/applications/bits.ear

COPY oc4j/config/server.xml /oc4j/j2ee/home/config/server.xml
COPY oc4j/config/amazon_s3.cer /oc4j/j2ee/home/config/amazon_s3.cer
COPY oc4j/config/s3_console_aws_amazon.cer /oc4j/j2ee/home/config/s3_console_aws_amazon.cer
COPY oc4j/config/default-web-site.xml /oc4j/j2ee/home/config/default-web-site.xml
COPY oc4j/config/bits /oc4j/j2ee/home/config/bits
EXPOSE 8888
VOLUME /oc4j
WORKDIR /oc4j
CMD ["/oc4j/bin/oc4j","-start"]
