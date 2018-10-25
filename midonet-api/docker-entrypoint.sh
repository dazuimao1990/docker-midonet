#!/bin/bash
#add debug mode 
[ $DEBUG ] && set -x
#Define the midonet-api profile
sed -i -e 's/org.midonet.api.auth.keystone.v2_0.KeystoneService/org.midonet.api.auth.MockAuthService/g' \
       -e "s/127.0.0.1:2181/${ZK_ENDPOINTS:-'127.0.0.1:2181'}/g" \
       -e "s#'/var/lib/tomcat7/webapps/host_uuid.properties'#'/var/lib/tomcat/webapps/host_uuid.properties'#g" /usr/share/midonet-api/WEB-INF/web.xml

#Modify tomcat configuration
sed -i -e '72 aURIEncoding="UTF-8"' \
       -e '72 amaxHttpHeaderSize="65536"' /etc/tomcat/server.xml
sed -i -e '73s/^/               /' \
       -e '74s/^/               /' /etc/tomcat/server.xml
#Define the midonet-api profile
cat > /etc/tomcat/Catalina/localhost/midonet-api.xml <<EOF
<Context   
    path="/midonet-api"
    docBase="/usr/share/midonet-api"
    antiResourceLocking="false"
    privileged="true"
/>
EOF
#Add the midonet-cli entrance
cat > ~/.midonetrc <<EOF
[cli]
api_url = http://localhost:8080/midonet-api
EOF

#add pause mode 
[ $PAUSE ] && sleep $PAUSE

exec $@