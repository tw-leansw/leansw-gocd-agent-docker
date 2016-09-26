# Image:
# registry.aliyuncs.com/leansw/gocd-agent-dind:16.9.0
# Usage:
# docker run -d -e GO_SERVER=x.x.x.x registry.aliyuncs.com/leansw/gocd-agent-dind:16.9.0

FROM docker:1.12.1-dind

ARG GO_VERSION=16.9.0-4001

ADD go-agent-start.sh /etc/service/go-agent/run
WORKDIR /tmp

RUN apk add --no-cache unzip openjdk7 git mercurial subversion bash wget && \ 
    mkdir -p /etc/service/go-agent && \
    wget https://download.go.cd/binaries/${GO_VERSION}/generic/go-agent-${GO_VERSION}.zip -O /tmp/go-agent.zip && \
    mkdir -p /run/go-agent && unzip -j /tmp/go-agent.zip -d /run/go-agent && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh 

CMD ["bash", "/run/go-agent/agent.sh"]
