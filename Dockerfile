######
# See: https://hub.docker.com/_/php/
######

FROM php:5.6-fpm
MAINTAINER yuxuewen <8586826@qq.com>


COPY ./composer /usr/bin/composer
WORKDIR /opt

RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib " > /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ stretch main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib" >> /etc/apt/sources.list \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


RUN apt-get update \
    &&  apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        wget \
        vim \
        git \
        git-gui \
        zip \
        unzip \
        supervisor \
        cron \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysql mysqli pdo pdo_mysql zip opcache \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && wget https://npm.taobao.org/mirrors/node/v8.9.0/node-v8.9.0-linux-x64.tar.xz \
    && tar xf node-v8.9.0-linux-x64.tar.xz \
    && mv node-v8.9.0-linux-x64 node

ENV PATH /opt/node/bin:$PATH
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
WORKDIR /source













