# docker-prosody

Docker container for Prosody communication server.

## Setup

### Configuration

Copy config dir from running container to docker host:

```bash
docker cp <container>:/etc/prosody /srv
```

Make the necessary changes and mount it as volume inside the container.

### User management

Also you must create first user to connect to the server:

```bash
docker exec <container> prosodyctl register <user> <domain> <password>
```

## Running

```bash
docker run -d \
   -p 5222:5222 \
   -p 5269:5269 \
   -v /srv/prosody /etc/prosody \
   osminogin/prosody
```

### Unit file for systemd

```
[Unit]
Description=Prosody service
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
RestartSec=30s
Restart=on-failure
ExecStartPre=-/usr/bin/docker rm -f prosody
ExecStartPre=/usr/bin/docker pull osminogin/prosody
ExecStart=/usr/bin/docker run --name prosody \
	-p 5222:5222 \
	-p 5269:5269 \
	-v /srv/prosody /etc/prosody \
	osminogin/prosody
ExecStop=/usr/bin/docker stop prosody

[Install]
WantedBy=multi-user.target
```
