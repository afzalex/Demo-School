FROM ubuntu:latest

ENV GITEA_HOST gitea-server
ENV GITEA_ADMIN_USERNAME "admin"
ENV GITEA_ADMIN_PASSWORD "password#123"

RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
RUN apt-get update
RUN apt-get install docker.io -y
RUN apt-get install jq nmap curl -y
RUN apt-get install expect -y

COPY entrypoint.sh entrypoint.sh
COPY scripts scripts
ENTRYPOINT ["/entrypoint.sh"]