#!/bin/bash

## Taken from https://github.com/prosody/prosody-docker
set -e

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ]; then
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

exec "$@"
