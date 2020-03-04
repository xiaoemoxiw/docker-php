######
# See: https://hub.docker.com/_/php/
######

FROM php:7.1-fpm
MAINTAINER yuxuewen <8586826@qq.com>


#COPY ./composer /usr/bin/composer
WORKDIR /opt

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer


RUN  sed -i "1i deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib \n deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib \n deb http://mirrors.aliyun.com/debian-security stretch/updates main \n deb-src http://mirrors.aliyun.com/debian-security stretch/updates main \n deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib \n deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib \n deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib \n deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib"  /etc/apt/sources.list \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


RUN apt-get update \
    &&  apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
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
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip opcache sg11 \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN composer config -g repo.packagist composer https://packagist.laravel-china.org \
    && wget https://npm.taobao.org/mirrors/node/v10.16.0/node-v10.16.0-linux-x64.tar.xz \
    && tar xf node-v10.16.0-linux-x64.tar.xz \
    && mv node-v10.16.0-linux-x64 node7

ENV PATH /opt/node/bin:$PATH
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
WORKDIR /source













