#!/bin/sh
#
# Purpose: Starting Apache damon...
# Version: 1.0
#

CGI_PATH=/var/www/localhost/cgi-bin
CONFIG_PATH=/etc/nginx/nginx.conf
DOCUMENT_ROOT=/var/www/localhost/htdocs
LOGS_PATH=/var/www/localhost/logs
VHOST_PATH=/etc/nginx/conf.d/localhost.conf

#
# Checks if required folder exists. If not, it will be created.
#
if [[ ! -d ${CGI_PATH} ]]
then
    mkdir ${CGI_PATH}
fi

if [[ ! -d ${DOCUMENT_ROOT} ]]
then
    mkdir ${DOCUMENT_ROOT}
fi

if [[ ! -d ${LOGS_PATH} ]]
then
    mkdir ${LOGS_PATH}
fi

#
# Set server name
#
if [[ ! -z ${NGINX_SERVER_NAME} ]]
then
    sed -i "s/server_name localhost;/server_name localhost ${NGINX_SERVER_NAME};/" ${VHOST_PATH}
fi

#
# Create user and group
#
if [[ ! -z ${NGINX_RUN_USER} ]]
then

    if [[ -z ${NGINX_RUN_GROUP} ]]
    then
        NGINX_RUN_GROUP=nginx
    fi

    sed -i "s/user nginx;/user ${NGINX_RUN_USER} ${NGINX_RUN_GROUP};/" ${CONFIG_PATH}

    if [[ ! -z ${NGINX_RUN_USER_ID} ]] && [[ ! -z ${NGINX_RUN_GROUP_ID} ]]
    then
        addgroup -g ${NGINX_RUN_GROUP_ID} ${NGINX_RUN_GROUP}
        adduser -u ${NGINX_RUN_USER_ID} -G ${NGINX_RUN_GROUP} -h ${DOCUMENT_ROOT} ${NGINX_RUN_USER}

    else
        addgroup ${NGINX_RUN_GROUP}
        adduser -G ${NGINX_RUN_GROUP} -h ${DOCUMENT_ROOT} ${NGINX_RUN_USER}
    fi

    chown -R ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} ${DOCUMENT_ROOT}
fi

#
# Starting nginx daemon...
#
exec /usr/sbin/nginx -g 'daemon off;'
