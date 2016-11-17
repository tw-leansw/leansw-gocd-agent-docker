# TW Leansw GoCD Agent Dockerfile

## go-agent-dind

This container will run another docker instance inside itself, which is considered as dind (docker in docker).

Command to run an agent:
```
docker run -d --restart=always --name=gocd-agent-dind -l io.rancher.container.network=true -e GO_SERVER=<GoCD-Service-IP> reg.dev.twleansw.com/leansw/gocd-agent-dind:16.11.0
```

## go-agent-docker

This container should run with the host docker sock file mounted inside.

Command to run an agent:
```
docker run -d --restart=always --name=gocd-agent-docker -v /var/run/docker.sock:/var/run/docker.sock -l io.rancher.container.network=true -e GO_SERVER=<GoCD-Service-IP> registry.cn-hangzhou.aliyuncs.com/leansw/go_agent_docker:16.9.0-3
```
