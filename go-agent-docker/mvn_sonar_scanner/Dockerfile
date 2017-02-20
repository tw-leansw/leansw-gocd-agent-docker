# Build stable release using: docker build --build-arg GO_VERSION=16.0-xxxx -t gocd-agent .
# Build experimental build using: docker build --build-arg GO_VERSION=16.0-xxxx  --build-arg DOWNLOAD_URL=https://download.gocd.io/experimental/binaries -t gocd-agent .
FROM phusion/baseimage:0.9.18
MAINTAINER GoCD <go-cd-dev@googlegroups.com>

ARG GO_VERSION="17.1.0-4511"
ARG DOWNLOAD_URL="https://download.gocd.io/binaries"

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y -q unzip openjdk-8-jdk git mercurial subversion wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/service/go-agent
ADD go-agent-start.sh /etc/service/go-agent/run

ADD $DOWNLOAD_URL/$GO_VERSION/deb/go-agent_${GO_VERSION}_all.deb /tmp/go-agent.deb

WORKDIR /tmp
RUN dpkg -i /tmp/go-agent.deb \
    && sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent \
    && rm -rf /tmp/* /var/tmp/*

ENV DOCKERIZE_VERSION v0.3.0
ARG DOCKERIZE_DOWNLOAD_URL="https://github.com/jwilder/dockerize/releases/download"
RUN set -x \
        && wget $DOCKERIZE_DOWNLOAD_URL/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV MAVEN_VERSION 3.3.9
RUN set -x \
        && wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
        && tar -C /usr/share -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz \
        && ln -s /usr/share/apache-maven-$MAVEN_VERSION/ /usr/share/maven \
        && echo 'export PATH=/usr/share/maven/bin:$PATH' >> /var/go/.profile

ENV SONAR_SCANNER_VERSION 2.8
RUN set -x \
        && wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-$SONAR_SCANNER_VERSION.zip \
        && unzip sonar-scanner-$SONAR_SCANNER_VERSION.zip -d /usr/share/ \
        && rm sonar-scanner-$SONAR_SCANNER_VERSION.zip \
        && ln -s /usr/share/sonar-scanner-$SONAR_SCANNER_VERSION/ /usr/share/sonar-scanner \
        && echo 'export PATH=/usr/share/sonar-scanner/bin:$PATH' >> /var/go/.profile \
        && echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64' >> /var/go/.profile

CMD ["bash", "-c", "source /var/go/.profile && /sbin/my_init"]
