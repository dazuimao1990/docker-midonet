# midolman

容器化的 midolman 项目

- 构建命令：

`docker build -t rainbond/midolman:v2016.05 .`

- 可用的参数：

-e ZK_ENDPOINTS="192.168.1.1:2181，192.168.1.2:2181"  #规定zookeeper连接地址
-e CASSANDRA_SEEDS="1.1.1.1,2.2.2.2,3.3.3.3"          #规定cassandra连接地址
-e CASSANDRA_REP=3                                    #规定cassandra复制因子
-e PAUSE=100000                                       #开启暂停模式，持续时间为100000秒，具体停在哪里，去看 docker-entrypoint.sh
-e DEBUG=1                                            #开启debug模式

- 启动命令：

`docker run --rm -dti --name=midoman --net=host -e ZK_ENDPOINTS="1.1.1.1:2181,2.2.2.2:2181,3.3.3.3:2181" -e CASSANDRA_SEEDS="1.1.1.1,2.2.2.2,3.3.3.3" -e CASSANDRA_REP=3 rainbond/midolman:v2016.05`
