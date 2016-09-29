# Image:
# registry.aliyuncs.com/leansw/gocd-agent-dind:16.9.0-ssh
# Usage:
# docker run -d -e GO_SERVER=x.x.x.x registry.aliyuncs.com/leansw/gocd-agent-dind:16.9.0

FROM docker:1.12.1-dind

ARG GO_VERSION=16.9.0-4001
WORKDIR /tmp

RUN apk add --no-cache unzip openjdk7 git mercurial subversion bash wget openssh pwgen && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh 

RUN mkdir -p /etc/service/go-agent && \
    wget http://artifactory.dev.twleansw.com:8081/artifactory/test-repo/go-agent/${GO_VERSION}/go-agent-${GO_VERSION}.zip -O /tmp/go-agent.zip && \
    mkdir -p /run/go-agent && unzip -j /tmp/go-agent.zip -d /run/go-agent && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh 

ADD .ssh /root/.ssh

CMD bash -c 'fork /usr/local/bin/dockerd-entrypoint.sh & && source /run/go-agent/agent.sh'
