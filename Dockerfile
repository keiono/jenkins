FROM jenkins:latest

# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y curl zsh vim

# Env variables
ENV MAVEN_VERSION 3.3.3
ENV MAVEN_HOME /usr/share/maven
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER jenkins