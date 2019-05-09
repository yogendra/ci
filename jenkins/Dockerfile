FROM jenkinsci/blueocean
USER root
RUN apk -U add  cloudfoundry-cli --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

USER jenkins
COPY usr/share/jenkins/ref /usr/share/jenkins/ref
COPY tmp/plugins.txt /tmp/plugins.txt
RUN install-plugins.sh < /tmp/plugins.txt

CMD ["--prefix=/jenkins"]

