FROM jenkinsci/blueocean
USER root

RUN apk -U add  cloudfoundry-cli --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
# Shit for getting docker-compose in this.
RUN apk add py-pip  &&\
    apk add python-dev libffi-dev openssl-dev gcc libc-dev make &&\
    pip install --upgrade pip &&\
    pip install docker-compose

USER jenkins
COPY usr/share/jenkins/ref /usr/share/jenkins/ref
COPY tmp/plugins.txt /tmp/plugins.txt
RUN install-plugins.sh < /tmp/plugins.txt

CMD ["--prefix=/jenkins"]

