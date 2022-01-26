FROM debian:10-slim

# Generic
RUN apt-get update && apt-get install -y apt-transport-https gnupg2 curl lsb-release software-properties-common less unzip

# Repositories: Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Installing
RUN apt-get update
RUN apt-get install -y terraform

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Cleaning up
RUN apt-get clean all

RUN apt-get install -y git
RUN mkdir /root/iac

#COPY iac/ /root/iac/
WORKDIR /root/iac/