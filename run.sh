#!/usr/bin/env bash

KEY_SIZE="${KEY_SIZE:-2048}"
WEB_ROOT="${WEB_ROOT:-/var/www}"

if [ -z "$DOMAINS" ]
then
	echo "DOMAINS env variable cannot be empty"
	exit 1
fi

DOMAIN_STRING=""
for i in $DOMAINS;
do
	DOMAIN_STRING="$DOMAIN_STRING -d $i"
done

if [ -z "$NO_UPDATE" ]
then
	apt-get update
	apt-get upgrade -y letsencrypt
	apt-get clean
fi

if [ ! -z "$EMAIL" ]
then
	EMAIL_OPT="--email $EMAIL"
fi

if [ ! -z $STAGING ]
then
	STAGING_OPT="--staging"
fi

if [ -z "$DEBUG" ]
then
	letsencrypt $STAGING_OPT --non-interactive --text -v $EMAIL_OPT --agree-tos --rsa-key-size $KEY_SIZE certonly --webroot -w $WEB_ROOT $DOMAIN_STRING
else
	echo "letsencrypt $STAGING_OPT --non-interactive --text -v $EMAIL_OPT --agree-tos --rsa-key-size $KEY_SIZE certonly --webroot -w $WEB_ROOT $DOMAIN_STRING"
fi

