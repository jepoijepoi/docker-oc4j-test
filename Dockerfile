FROM openjdk:7-alpine
RUN mkdir /oc4j
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV ORACLE_HOME=/oc4j
ENV DS_CONFIG_URL=''
ENV APP_URL=''
ENV OC4J_ADMIN_PASSWORD=''
COPY oc4j_extended_101350.zip /oc4j/oc4j.zip
COPY run.sh /run.sh
RUN cd oc4j && \
    unzip oc4j.zip && \
    rm oc4j.zip
COPY oc4j/config/system-jazn-data.xml /oc4j/j2ee/home/config/system-jazn-data.xml
COPY oc4j/config/jms.xml /oc4j/j2ee/home/config/jms.xml
VOLUME /oc4j
WORKDIR /
ENTRYPOINT ["./run.sh"]
