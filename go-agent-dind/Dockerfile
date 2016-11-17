# Image:
# registry.aliyuncs.com/leansw/gocd-agent-dind:16.9.0-ssh
# Usage:
# docker run -d -e GO_SERVER=x.x.x.x registry.aliyuncs.com/leansw/gocd-agent-dind:16.11.0

FROM docker:1.12.3-dind

ARG GO_VERSION=16.11.0-4185
WORKDIR /tmp

RUN apk add --no-cache unzip openjdk7 git mercurial subversion bash wget openssh pwgen && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh 

RUN mkdir -p /etc/service/go-agent && \
    wget https://download.go.cd/binaries/${GO_VERSION}/generic/go-agent-${GO_VERSION}.zip -O /tmp/go-agent.zip && \
    mkdir -p /run/go-agent && \
    unzip -j /tmp/go-agent.zip -d /run/go-agent && \
    rm -rf /tmp/*

ADD .ssh /root/.ssh
ADD ca.crt /etc/docker/certs.d/reg.dev.twleansw.com/ca.crt
ADD dind-entrypoint.sh /usr/local/bin/dind-entrypoint.sh
ADD dockerd-entrypoint.sh /usr/local/bin/dockerd-entrypoint.sh
ADD autoregister.properties /run/go-agent/config/autoregister.properties
CMD bash /usr/local/bin/dind-entrypoint.sh
