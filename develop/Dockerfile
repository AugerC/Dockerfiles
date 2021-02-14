FROM ubuntu:20.04

USER root

##################################
# INSTALL NEEDED PACKAGES
# Install basics
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install -y wget vim curl lsb-release gnupg2 gnupg gnupg1 apt-utils dnsutils iputils-ping

##################################
# INSTALL NEEDED PACKAGES
# Install vim dependences
RUN apt install -y python3 python3-pip netcat dnsutils zip zsh git


##################################
# INSTALL NEEDED PACKAGES

# Kubectl
# Helm2
RUN wget https://get.helm.sh/helm-v2.11.0-linux-amd64.tar.gz && tar -xvf helm-v2.11.0-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm2

# Helm3
RUN wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz -O helm.tar.gz && tar -xvf helm.tar.gz
RUN mv linux-amd64/helm /usr/local/bin

# FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all

# AZ CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

##################################
# INSTALL NEEDED PACKAGES
# Install ZSH stuff
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


##################################
# INSTALL NEEDED PACKAGES
RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && chmod +x install.sh
RUN sh install.sh
RUN chsh -s $(which zsh)

# Clean and delete
RUN rm -rf linux-amd64
RUN apt update && apt upgrade -y && apt autoremove -y && apt clean all
