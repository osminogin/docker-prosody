FROM debian:latest
MAINTAINER Vladimir Osintsev <oc@co.ru>

ENV DEBIAN_FRONTEND noninteractive
ENV PROSODY_LIST /etc/apt/sources.list.d/prosody.list
ENV PROSODY_CFG /etc/prosody/prosody.cfg.lua

RUN echo 'deb http://packages.prosody.im/debian stable main' > $PROSODY_LIST && \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 74D9DBB5 && \
    apt-get update && apt-get -y install \
        lua-event \
        lua-zlib \
        lua-dbi-mysql \
        lua-dbi-postgresql \
        lua-dbi-sqlite3 \
        prosody

RUN sed -i '/^--use_libevent /c use_libevent = true;' $PROSODY_CFG && \
    sed -i '1s/^/daemonize = false;\n/' $PROSODY_CFG && \
    ln -sf /dev/stdout /var/log/prosody/prosody.log && \
    ln -sf /dev/stderr /var/log/prosody/prosody.err

EXPOSE 80 443 5222 5269 5347 5280 5281
CMD ["prosodyctl", "start"]
