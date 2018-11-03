FROM centos:7.3.1611

MAINTAINER guox <guox@goodrain.com>

RUN rm -rf /etc/yum.repos.d/*

COPY midonet.repo /etc/yum.repos.d/

COPY docker-entrypoint.sh /

ENV TZ=Asia/Shanghai

RUN yum makecache fast \
&& yum install -y net-tools tomcat midonet-api python-midonetclient \
&& yum clean all \
&& chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/libexec/tomcat/server","start" ]





