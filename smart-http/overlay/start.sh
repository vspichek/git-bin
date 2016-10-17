#!/bin/bash
# gitbox startup script

set -e

#logger
sflog() {
    echo $*
}

#start services function
startc() {
    sflog "Services for container are being started..."
    /etc/init.d/php5-fpm start
    /etc/init.d/fcgiwrap start
    /etc/init.d/nginx start
    sflog "The container services have started..."
}

#stop services function
stopc() {
    sflog "Services for container are being stopped..."
    /etc/init.d/nginx stop
    /etc/init.d/php5-fpm stop
    /etc/init.d/fcgiwrap stop
    sflog "Services for container have successfully stopped. Exiting."
}

#trap "docker stop <container>" and shuts services down cleanly
trap "stopc; exit" TERM

#modify config files with fqdn
sed -i "s,MYSERVER,${FQDN},g" /etc/git/*

chgrp git /var/www/gitlist/cache
chmod g+w /var/www/gitlist/cache

#init
repo-admin -v
ng-auth -v

#start init.d services
startc

#pause script to keep container running...
sflog "Services for container successfully started."

sleep $[3600*24*365*25] &
wait 
