from docker:1.12.0-dind

ARG GO_VERSION=16.7.0-3819

# install gocd-agent 
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN apk add --no-cache unzip openjdk7 git mercurial subversion dpkg

RUN mkdir -p /etc/service/go-agent
ADD gocd-agent/go-agent-start.sh /etc/service/go-agent/run

ADD https://download.go.cd/binaries/16.7.0-3819/deb/go-agent_16.7.0-3819_all.zip /tmp/go-agent.zip

WORKDIR /tmp
RUN unzip /tmp/go-agent.zip /etc/default/go-agent
RUN sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/etc/default/go-agent/agent.sh"]