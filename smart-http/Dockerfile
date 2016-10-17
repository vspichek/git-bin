# https://github.com/nmarus/docker-gitbox

FROM armhf/debian:jessie
MAINTAINER Vlad Spichek <vspichek@gmail.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    apt-get -y install git gitweb wget nginx-full php5-fpm fcgiwrap apache2-utils && \
    apt-get clean

# run as group git
RUN groupadd --gid 1000 git && \
    sed -i 's/\(group\)\(.*\)www-data/\1\2git/gi' /etc/php5/fpm/pool.d/www.conf /etc/init.d/fcgiwrap

# Install gitlist
RUN mkdir -p /var/www/gitlist/cache && \
    wget -qO - https://s3.amazonaws.com/gitlist/gitlist-0.5.0.tar.gz | tar xzf - -C /var/www

COPY overlay /

# Setup Container
VOLUME ["/repos"]
VOLUME ["/ng-auth"]
VOLUME ["/var/log/nginx"]
EXPOSE 80

# Startup
CMD ["/start.sh"]
