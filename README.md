# docker-letsencrypt-webroot
Docker image used for Let's Encrypt webroot cert obtention.

Contains a Let's Encrypt client, and a script updating/running the client,
using the environment variables as parameters.

Two volumes should be mounted :
- /var/www (or other www-root specified by env, see below) should be served
  by the server for /.well-known/acme-challenge location
- /etc/letsnecrypt contains the generated certificates

Docker image run and restarting the services using the certificates is left
is left to the user : no need to provide root access to the host machine
to this image...

# Env variables

## Certificate
DOMAINS: domains for the certificate. Example: `example.com www.example.com` (required)
EMAIL: email for Let's Encrypt alerts and renewal notifications
KEY_SIZE: The RSA key size

## Container functionnality
NO_UPDATE: does not force the upgrade of the Let's Encrypt client and
dependencies if this environment variable is not empty
DEBUG: instead of running the Let's Encrypt client, prints the command
that would have been run if this environment variable is not empty
WEB_ROOT: The directory that is being mounted as volume, which location
on the host is served for location /.well-known/acme-challenge by the
web server
STAGING: uses the Let's Encrypt staging servers to generate fake certs
to test the server configuration

# Examples

#### Standard run, host web server has a /data/webroot webroot:

    docker run --rm -v /data/webroot:/var/www -v /etc/letsencrypt:/etc/letsencrypt -e DOMAINS="example.com www.example.com" -e EMAIL=sysadmins@example.com -e KEY_SIZE=4096 rlejolivet/letsencrypt-webroot

The generated certificates will be in /etc/letsencrypt/archive/example.com.
A symlink to the latest certificate will be in /etc/letsencrypt/live/example.com.
Running the same command again will renew the certificate if it has less than 30 days remaining (Let's Encrypt default).

#### Quick staged run:

      docker run --rm -ti -e NO_UPDATE=y -e STAGING=y -e DOMAINS="example.com www.example.com" letsencrypt-webroot
