FROM jenkins/ssh-agent:debian-jdk21
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get install -y python3-launchpadlib
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt update && apt install -y python3.11 python3.11-venv python3.11-dev python3-pip
COPY --from=docker /usr/local/bin/docker  /usr/local/bin/

RUN sed -i '/^PermitRootLogin/s/no/yes/' /etc/ssh/sshd_config
RUN echo "PubkeyAcceptedAlgorithms +ssh-rsa" >> /etc/ssh/sshd_config