FROM sonarqube:latest  

# Plugin Versions

ENV SONAR_HTML_PLUGIN 3.0.1.1444
ENV SONAR_WEB_CONTEXT "/sonarqube"

USER sonarqube
# Add plugins
ADD http://central.maven.org/maven2/org/sonarsource/html/sonar-html-plugin/${SONAR_HTML_PLUGIN}/sonar-html-plugin-${SONAR_HTML_PLUGIN}.jar extensions/plugins/sonar-html-plugin-${SONAR_HTML_PLUGIN}.jar
RUN echo "sonar.web.context=${SONAR_WEB_CONTEXT}" >> /opt/sonarqube/conf/sonar.properties

USER root
RUN set -e && \
    chmod a+r extensions/plugins/sonar-html-plugin-${SONAR_HTML_PLUGIN}.jar && \
    chown sonarqube:sonarqube extensions/plugins/sonar-html-plugin-${SONAR_HTML_PLUGIN}.jar

USER sonarqube
