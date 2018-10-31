#!/bin/bash
#add debug mode 
[ $DEBUG ] && set -x
#Define the midonet-api profile
:> /etc/midolman/midolman.conf
cat > /etc/midolman/midolman.conf << EOF
[zookeeper]
zookeeper_hosts = ${ZK_ENDPOINTS:-"127.0.0.1:2181"}
root_key = /midonet/v1
session_timeout = 30000
session_gracetime = 30000
[cassandra]
servers = ${CASSANDRA_SEEDS:-"127.0.0.1"}
replication_factor = ${CASSANDRA_REP:-1}
cluster = midonet
bgpd_binary = /usr/lib/quagga/
EOF
#Define midonet_host_id.properties
if [[ ${MIDO_ID} ]];then 
  echo "host_uuid=${MIDO_ID}" > /etc/midonet_host_id.properties
else
  echo 'midonet_host_id undefined! please export $MIDO_ID'
  exit 1
fi
#add PAUSE mode 
[ $PAUSE ] && sleep $PAUSE
#config
cat << EOF | mn-conf set -t default
zookeeper {
    zookeeper_hosts = "${ZK_ENDPOINTS:-'127.0.0.1:2181'}"
}
cassandra {   
    servers = "${CASSANDRA_SEEDS:-"127.0.0.1"}"
}
EOF

echo "cassandra.replication_factor : ${CASSANDRA_REP:-1}" | mn-conf set -t default

if [[ $GATEWAY = "true" ]];then
  mn-conf template-set -h local -t agent-gateway-large
  mv /etc/midolman/midolman-env.sh /etc/midolman/midolman-env.sh.bak
  cp /etc/midolman/midolman-env.sh.gateway.large /etc/midolman/midolman-env.sh
else
  mn-conf template-set -h local -t agent-compute-medium
  mv /etc/midolman/midolman-env.sh /etc/midolman/midolman-env.sh.bak
  cp /etc/midolman/midolman-env.sh.compute.medium /etc/midolman/midolman-env.sh
fi

#sed -i '/\[Service\]/a\LimitNOFILE=60000' /usr/lib/systemd/system/midolman.service

bash -x /usr/share/midolman/midolman-prepare

exec $@
