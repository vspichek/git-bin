# https://github.com/nmarus/docker-gitbox

FROM armhf/debian:jessie
MAINTAINER Vlad Spichek <vspichek@gmail.com>

# Setup Container
VOLUME ["/repos"]
VOLUME ["/ng-auth"]
EXPOSE 80

# Setup Environment Variables
ENV ADMIN="gitadmin"

# Setup APT
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update, Install Prerequisites, Clean Up APT
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    apt-get -y install git wget nginx-full php5-fpm fcgiwrap apache2-utils && \
    apt-get clean

# Setup Container User
# Setup nginx php-fpm services to run as user git, group git
RUN groupadd --gid 1000 git && \
    sed -i 's/\(group\)\(.*\)www-data/\1\2git/gi' /etc/php5/fpm/pool.d/www.conf /etc/init.d/fcgiwrap

# Install gitlist
RUN mkdir -p /var/www/gitlist/cache && \
    wget -qO - https://github.com/klaussilveira/gitlist/archive/0.5.0.tar.gz | \
    tar xzf - -C /var/www --transform='s,^gitlist-0.5.0,gitlist,' && \
    find /var/www/gitlist -type d | xargs chmod g+ws && \
    chgrp -R git /var/www/gitlist

COPY overlay /

# Startup
CMD ["/start.sh"]
