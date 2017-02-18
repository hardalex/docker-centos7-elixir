########## OS ##########
FROM centos:centos7

RUN yum update -y && yum clean all
RUN yum reinstall -y glibc-common
########## OS ##########


########## ENV ##########
# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

# Set app env
ENV HOME /root
########## ENV ##########


########## MIDDLEWARE ##########
WORKDIR /usr/local/src

RUN yum install -y gcc gcc-c++ make openssl-devel ncurses-devel && yum clean all
RUN yum install -y epel-release.noarch && yum clean all
RUN yum install -y http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_18.1-1~centos~7_amd64.rpm && yum clean all
RUN yum install -y sudo wget git tar bzip2 incron vim mysql && yum clean all
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash && export NVM_DIR="/root/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install node
########## MIDDLEWARE ##########


########## ELIXIR ##########
ENV ELIXIR_VERSION 1.3.2

# Build Elixir
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /usr/local/src/elixir
RUN git checkout refs/tags/v${ELIXIR_VERSION}
RUN make clean install
