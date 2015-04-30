docker-hubot-flowdock
=====================

### Example build and deployment (using boot2docker)

```
boot2docker init && boot2docker up && boot2docker ssh
git clone https://github.com/mrwulf/docker-hubot-flowdock.git
cd docker-hubot-flowdock/
git pull && docker build --tag=hubot --rm=true .
docker run -d --name=hubot hubot:latest
```