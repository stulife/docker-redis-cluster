# This tag use ubuntu 14.04
FROM redis:alpine

MAINTAINER stulife <stulife>

# Some Environment Variablesss  
ENV HOME /root
RUN apk update && apk --update add ruby ruby-rdoc  supervisor
RUN /usr/bin/gem install redis

RUN mkdir /redis-trib && \
    mkdir /redis-data && \
    mkdir /redis-data/7000 && \
    mkdir /redis-data/7001 && \
    mkdir /redis-data/7002 && \
    mkdir /redis-data/7003 && \
    mkdir /redis-data/7004 && \
    mkdir /redis-data/7005 && \
    mkdir -p /var/log/supervisor/ && \
    mkdir -p /etc/supervisor.d 
  
# Add all config files for all clusters
ADD ./docker-data/redis-conf /redis-conf
ADD ./docker-data/redis-trib.rb  /redis-trib
# Add supervisord configuration
ADD ./docker-data/supervisord.conf /etc/supervisor.d/supervisord.ini

ADD ./docker-data/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 7000 7001 7002 7003 7004 7005

CMD ["/bin/sh", "/start.sh"]
ENTRYPOINT ["/bin/sh", "/start.sh"]
