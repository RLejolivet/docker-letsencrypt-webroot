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

TODO =)
