docker-hubot-flowdock
=====================

### Example build and deployment

git clone this repository
```
cd docker-hubot-flowdock/
docker build --tag=hubot-fd
docker run -d -e "HUBOT_PORT=8080" -e "HUBOT_ADAPTER=flowdock" -e "HUBOT_NAME=benbot" -e "NAME=benbot" -e "HUBOT_FLOWDOCK_API_TOKEN=TOKEN" -e "PORT=8080" -e "HUBOT_FLOWDOCK_ALLOW_ANONYMOUS_COMMANDS=1" --name=benbot hubot-fd
```