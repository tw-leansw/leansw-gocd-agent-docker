# Image:
# registry.aliyuncs.com/leansw/gocd-agent-docker:16.11.0
# Usage:
# docker run -d -e GO_SERVER=x.x.x.x registry.aliyuncs.com/leansw/gocd-agent-docker:16.11.0

FROM docker:1.12.3
ARG GO_VERSION=17.1.0-4511
WORKDIR /tmp
RUN echo "ipv6" >> /etc/modules && \
    apk add --no-cache unzip zip openjdk7 git mercurial subversion bash wget openssh pwgen tzdata && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN mkdir -p /etc/service/go-agent && \
    wget https://download.gocd.io/binaries/${GO_VERSION}/generic/go-agent-${GO_VERSION}.zip -O /tmp/go-agent.zip && \
    mkdir -p /run/go-agent && \
    unzip -j /tmp/go-agent.zip -d /run/go-agent && \
    rm -rf /tmp/*

ADD ssh /root/.ssh
ADD remote-docker-entrypoint.sh /usr/local/bin/remote-docker-entrypoint.sh
ADD autoregister.properties /run/go-agent/config/autoregister.properties
CMD bash /usr/local/bin/remote-docker-entrypoint.sh
