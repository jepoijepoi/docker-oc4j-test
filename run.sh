#!/bin/sh
export OC4J_ADMIN_PASSWORD=$(strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n') 
sed -i 's/${OC4J_ADMIN_PASSWORD}/'$OC4J_ADMIN_PASSWORD'/g' /oc4j/j2ee/home/config/system-jazn-data.xml
echo "Default password for oc4jadmin user is $OC4J_ADMIN_PASSWORD. Please change it in the console"
wget -O /oc4j/j2ee/home/config/data-sources.xml $DS_CONFIG_URL
cd /oc4j
./bin/oc4j -start
