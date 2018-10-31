# midolman

容器化的 midolman 项目

- 构建命令：

`docker build -t rainbond/midolman:v2015.06 .`

- 可用的参数：

-e ZK_ENDPOINTS="192.168.1.1:2181，192.168.1.2:2181"  #规定zookeeper连接地址

-e CASSANDRA_SEEDS="1.1.1.1,2.2.2.2,3.3.3.3"          #规定cassandra连接地址

-e CASSANDRA_REP=3                                    #规定cassandra复制因子

-e PAUSE=100000                                       #开启暂停模式，持续时间为100000秒，具体停在哪里，去看 docker-entrypoint.sh

-e DEBUG=1                                            #开启debug模式

-e GATEWAY=true                                       #标示该节点是否为网关节点，并根据此修改配置，如不加变量，则视为计算节点

-e MIDO_ID=d2c42368-2d50-488a-bdf5-b936f6109f95       #标示midolman唯一ID，一般填写Rainbond host uuid

- 启动命令：

`docker run --rm -dti --name=midoman -v /lib/modules:/lib/modules --net=host -e MIDO_ID=d2c42368-2d50-488a-bdf5-b936f6109f95 -e ZK_ENDPOINTS="1.1.1.1:2181,2.2.2.2:2181,3.3.3.3:2181" -e CASSANDRA_SEEDS="1.1.1.1,2.2.2.2,3.3.3.3" -e CASSANDRA_REP=3 rainbond/midolman:v2015.06`
