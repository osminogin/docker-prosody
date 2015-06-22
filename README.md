# docker-prosody

## Running

```bash
docker run -d \
   -p 5222:5222 \
   -p 5269:5269 \
   -p localhost:5347:5347 \
   -e LOCAL=admin \
   -e DOMAIN=example.com \
   -e PASSWORD=changeme \
   -v /srv/prosody:/etc/prosody \
   osminogin/prosody
```
