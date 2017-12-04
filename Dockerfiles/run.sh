#!/bin/sh
#
# Purpose: Starting Apache damon...
# Version: 1.0
#

NGINX_LOGS=/var/www/localhost/logs

#
# Create nginx logs folder
#
if [[ ! -d ${NGINX_LOGS} ]]
then
    mkdir ${NGINX_LOGS}
fi

#
# Starting nginx daemon...
#
exec /usr/sbin/nginx -g 'daemon off;'
