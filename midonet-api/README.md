#midonet-api
容器化的 midonet-api 项目
构建命令：
`docker build -t midonet-api .`
可用的参数：
-e ZK_ENDPOINTS="192.168.1.1:2181，192.168.1.2:2181"  #规定zookeeper连接地址
-e PAUSE=100000                                       #开启暂停模式，持续时间为100000秒，具体停在哪里，去看 docker-entrypoint.sh
-e DEBUG=1                                            #开启debug模式

启动命令：
`docker run -dti --name=midonet-api --net=host -e ZK_ENDPOINTS="192.178.0.2:2181,182.122.156.23:2181" -e PAUSE=100000 midonet-api`