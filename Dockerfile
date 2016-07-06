FROM node:6.2.2
MAINTAINER Charles Wisniewski "ch@rlesw.com"

# Install redis-server and supervisor
RUN apt-get update
RUN apt-get -qqy install redis-server

# Install hubot & coffee-script globally
RUN npm install -g hubot coffee-script yo generator-hubot

# Create new hubot
RUN mkdir /opt/hubot && chmod  777 /opt/hubot
WORKDIR /opt/hubot
ADD package.json /opt/hubot/package.json
RUN npm install hubot-flowdock --save

RUN adduser yeoman; \ 
    echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman

USER yeoman
RUN yo hubot --owner="Charles" --name=$NAME --description="opsguy proxy" --adapter=flowdock --defaults
RUN rm hubot-scripts.json

# should not be running as root..
USER root
#TODO fix supervisor setup
#ADD supervisor.conf /etc/supervisor.conf

CMD ["/opt/hubot/bin/hubot"]
