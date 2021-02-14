FROM ubuntu:20.04

USER root

##################################
# INSTALL NEEDED PACKAGES
# Install basics
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install -y wget vim curl lsb-release gnupg2 gnupg gnupg1 apt-utils dnsutils iputils-ping

RUN mkdir -p /root/.config/nvim/ && \
		mkdir -p /root/zsh_custom/plugins


##################################
# INSTALL NEEDED PACKAGES
# Install vim dependences
RUN apt install -y python3 python3-pip netcat dnsutils zip zsh git


##################################
# INSTALL NEEDED PACKAGES
# Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
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
# NEOVIM
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract && cp -R squashfs-root/* /




##################################
# ZSH
RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && chmod +x install.sh
RUN sh install.sh
RUN chsh -s $(which zsh)

##################################
# ZSH PLUGINS
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/zsh_custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /root/zsh_custom/plugins/zsh-autosuggestions


##################################
# COPY FILES
COPY .zshrc /root/.zshrc
COPY init.vim /root/.config/nvim/
COPY coc-settings.json /root/.config/nvim/
COPY tmux.conf /root/.tmux.conf


##################################
# NVIM CONFIG
RUN wget install-node.now.sh/lts && chmod +x lts && ./lts -y
RUN npm install --global eslint prettier eslint-config-prettier eslint-plugin-prettier
RUN git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8
RUN nvim +'PlugInstall --sync' +qa
RUN nvim +'CocInstall coc-snippets coc-pairs coc-python coc-eslint coc-prettier coc-json coc-rust-analyzer --sync' +qa
RUN pip3 install jedi neovim pylint virtualenv



##################################sudo curl -sL install-node.now.sh/lts | bash
# Clean and delete
RUN rm -rf linux-amd64 helm-v2.11.0-linux-amd64.tar.gz helm.tar.gz install.sh kubectl lts
WORKDIR /root
RUN apt update && apt upgrade -y && apt autoremove -y && apt clean all
