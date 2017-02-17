FROM gocd/gocd-agent:latest
MAINTAINER qmxie@thoughtworks.com

ADD trusty.sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    curl \
    maven \
    openjdk-8-jdk \
    wget \
    && rm -rf /var/lib/apt/lists/*

ENV DOCKERIZE_VERSION v0.3.0
RUN set -x \
        && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.8.zip \
        && unzip sonar-scanner-2.8.zip -d /usr/share/ \
        && rm sonar-scanner-2.8.zip \
        && echo 'export PATH=/usr/share/sonar-scanner-2.8/bin:$PATH' >> /var/go/.profile \
        && echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64' >> /var/go/.profile
ADD autoregister.properties.tmpl /etc/autoregister.properties.tmpl
ENV AGENT_DIR /usr/share/go-agent/
CMD ["bash" "-c" "dockerize -wait $GO_SERVER_URL -timeout 5mins -template /etc/autoregister.properties.tmpl:$AGENT_DIR/config/autoregister.properties PRODUCTION_MODE=N /usr/share/go-agent/agent.sh"]
