
FROM ubuntu:20.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install -y wget vim curl lsb-release gnupg2 gnupg gnupg1 apt-utils dnsutils iputils-ping
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt update
RUN apt install -y python3 python3-pip netcat dnsutils zip zsh git
RUN apt install -y postgresql-client
RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && chmod +x install.sh
RUN sh install.sh
RUN chsh -s $(which zsh)
RUN apt update && apt upgrade -y && apt autoremove -y && apt clean all
