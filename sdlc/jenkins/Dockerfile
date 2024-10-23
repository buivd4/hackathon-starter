FROM jenkins/jenkins:jdk21

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_conf/jenkins.yaml
COPY jobdsl/ /var/jobdsl/