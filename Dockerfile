FROM ubuntu:latest AS base

WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
FROM base AS itar
ARG TAGS
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo
RUN addgroup --gid 1000 ritvars
RUN adduser --gecos "" --uid 1000 --gid 1000 --disabled-password ritvars
RUN usermod -g sudo ritvars
RUN passwd -d ritvars
USER ritvars
WORKDIR /home/ritvars
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN sudo -E apt-get install -y software-properties-common curl git build-essential && \
    sudo -E apt-add-repository -y ppa:ansible/ansible && \
    sudo -E apt-get update && \
    sudo -E apt-get install -y curl ansible build-essential && \
    sudo -E apt-get clean autoclean && \
    sudo -E apt-get autoremove --yes

RUN sudo -E apt-get install -y openssh-client git 
COPY . .
RUN sudo chown ritvars:ritvars ./* -R
RUN sudo chown ritvars:ritvars ./.* -R
ENV HOME=/home/ritvars
ENV USER=ritvars

# CMD ["sh", "-c", "ansible-playbook local.yml --vault-password-file=.pass -e 'ansible_become_pass=';sleep infinity"]
CMD ["sh", "-c", "ansible-playbook local.yml --tags='rust,alacritty' --vault-password-file=.pass -e 'ansible_become_pass=';sleep infinity"]

