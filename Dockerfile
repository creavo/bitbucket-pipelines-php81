FROM ubuntu:22.04

MAINTAINER Creavo <info@creavo.de>

# Set environment variables
ENV HOME /root

# MySQL root password
ARG MYSQL_ROOT_PASS=root

# Cloudflare DNS, removed since docker does not allow changes of /etc/hosts and /etc/resolv.conf
#RUN echo "nameserver 1.1.1.1" | tee /etc/resolv.conf > /dev/null

# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    mcrypt \
    unzip \
    wget \
    curl \
    openssl \
    ssh \
    locales \
    gnupg \
    less \
    sudo \
    mysql-server \
    redis-server

# add yarn-dependency
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    yarn \
    php-pear php8.1-mysql php8.1-zip php8.1-xml php8.1-mbstring php8.1-curl php8.1-json php8.1-pdo php8.1-tokenizer php8.1-cli php8.1-imap php8.1-intl php8.1-gd php8.1-xdebug php8.1-soap php8.1-gmp php-imagick \
    apache2 libapache2-mod-php8.1 \
    --no-install-recommends

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# final clean up
RUN DEBIAN_FRONTEND=noninteractive apt-get clean -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/lib/mysql/ib_logfile*

# RUN systemctl start redis-server && \
#     systemctl enable redis-server

# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN locale-gen en_US.UTF-8

# Timezone & memory limit
RUN echo "date.timezone=Europe/Berlin" > /etc/php/8.1/cli/conf.d/date_timezone.ini && echo "memory_limit=1G" >> /etc/php/8.1/apache2/php.ini

# Goto temporary directory.
WORKDIR /tmp
