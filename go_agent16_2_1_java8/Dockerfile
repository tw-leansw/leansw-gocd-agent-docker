from gocd/gocd-agent:16.2.1
USER go
RUN echo $PATH
RUN curl -L -s get.jenv.io | bash && \
    bash -c "source /var/go/.jenv/bin/jenv-init.sh && jenv repo update && jenv config auto true && jenv install java 1.8.0_71 && jenv install maven 3.3.9 && jenv clean"

ENV PATH=/var/go/.jenv/candidates/java/current/bin:/var/go/.jenv/candidates/maven/current/bin:$PATH

ENV SONAR_VERSION=2.6.1
WORKDIR /var/go

RUN curl --insecure -OL https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-${SONAR_VERSION}.zip
RUN unzip sonar-scanner-${SONAR_VERSION}.zip
RUN rm sonar-scanner-${SONAR_VERSION}.zip

ENV SONAR_RUNNER_HOME=/var/go/sonar-scanner-${SONAR_VERSION}
ENV PATH $PATH:/var/go/sonar-scanner-${SONAR_VERSION}/bin

USER root

FROM registry.aliyuncs.com/leansw/go_agent16_2_1_java8
ADD settings.xml /etc/maven/settings.xml
ADD settings.xml /usr/share/maven/conf/settings.xml

RUN mkdir -p /var/go/.m2 && mkdir -p /var/lib/go-agent/pipelines && chown go:go /var/go/.m2 && chown go:go /var/lib/go-agent/pipelines
VOLUME ["/var/go/.m2","/var/lib/go-agent/pipelines"]
RUN export SHELL=/bin/bash

ADD .ssh /var/go/.ssh
RUN chown -R go:go /var/go/.ssh

CMD bash -c "chown go:go /var/go/.m2 && chown go:go /var/lib/go-agent/pipelines && /sbin/my_init"



