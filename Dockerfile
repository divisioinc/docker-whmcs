FROM    ajoergensen/baseimage-ubuntu

LABEL	maintainer="Rizal Fauzie Ridwan <rizal@fauzie.my.id>"

ENV     APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

ENV     PHP_VERSION=7.3 \
        VIRTUAL_HOST=$DOCKER_HOST \
        HOME=/virtual/cp.dynamic.com/htdocs/ \
        PUID=1000 \
        PGID=1000 \
        TZ=America/Los_Angeles \
        WHMCS_SERVER_IP=10.0.1.104 \
        REAL_IP_FROM=10.0.1.0/16 \
        SSH_PORT=2222

COPY    build /build

RUN     build/setup.sh && rm -rf /build

COPY    root/ /

RUN     chmod -v +x /etc/my_init.d/*.sh /etc/service/*/run

EXPOSE  2222

VOLUME  /virtual/cp.dynamic.com/htdocs/
WORKDIR /virtual/cp.dynamic.com/htdocs/

# RUN     rm /etc/nginx/conf.d/default.conf
# RUN     mv /virtual/cp.dynamic.com/htdocs/admin /virtual/cp.dynamic.com/htdocs/pmadci
