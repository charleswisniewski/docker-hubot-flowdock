FROM centos:latest
MAINTAINER Brandon Wulf

ENV HUBOT_PORT 8080
ENV HUBOT_ADAPTER flowdock
ENV HUBOT_NAME opsguy
ENV HUBOT_FLOWDOCK_API_TOKEN xxxxxxxxxxxxxxxxxxxxxx
ENV PORT ${HUBOT_PORT}

EXPOSE ${HUBOT_PORT}

ENV http_proxy http://inetprox:8080
ENV https_proxy http://inetprox:8080

RUN echo "proxy=http://inetprox:8080" >> /etc/yum.conf
RUN yum install -y http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y nodejs npm redis python-setuptools git --enablerepo=epel

RUN yum install -y python-pip && pip install pip --upgrade
RUN pip install --no-deps --ignore-installed --pre supervisor


## RUN export http_proxy=http://inetprox:8080 && export https_proxy=http://inetprox:8080 && easy_install supervisor

#RUN npm config set proxy http://inetprox:8080
#RUN npm config set https-proxy http://inetprox:8080
RUN npm install -g yo generator-hubot

RUN adduser yeoman; \ 
    echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman

# Create new hubot
RUN mkdir /opt/hubot && chmod  777 /opt/hubot
WORKDIR /opt/hubot
RUN yo hubot --owner="Brandon <bwulf@labattfood.com>" --name=$HUBOT_NAME --description="opsguy proxy" --adapter=flowdock --defaults

USER root

#RUN hubot --create /opt/hubot
WORKDIR /opt/hubot
RUN npm install && chmod +x bin/hubot

ADD package.json /opt/hubot/package.json
ADD hubot-scripts.json /opt/hubot/hubot-scripts.json
#ADD run.sh /tmp/run.sh
#RUN chmod +x /tmp/run.sh

ADD supervisor.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]
