FROM openjdk:7-alpine
RUN mkdir /oc4j
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV ORACLE_HOME=/oc4j
#ENV OC4J_ADMIN_PASSWORD='welcome'
COPY oc4j_extended_101350.zip /oc4j/oc4j.zip
RUN cd oc4j && \
    unzip oc4j.zip && \
    rm oc4j.zip
COPY system-jazn-data.xml /oc4j/j2ee/home/config/system-jazn-data.xml
RUN  export OC4J_ADMIN_PASSWORD=$(strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n') && \
     sed -i 's/${OC4J_ADMIN_PASSWORD}/'$OC4J_ADMIN_PASSWORD'/g' /oc4j/j2ee/home/config/system-jazn-data.xml && \
     echo "Default password for oc4jadmin user is $OC4J_ADMIN_PASSWORD. Please change it in the console"
VOLUME /oc4j
WORKDIR /oc4j
ENTRYPOINT ["./bin/oc4j", "-start"]
