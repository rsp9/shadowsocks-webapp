## Yet another SIP003 plugin for shadowsocks, based on [v2ray](https://github.com/v2fly/v2ray-core)

## Build

* `go build`
* Alternatively, `docker build`

## Usage

See command line args for advanced usages.

### Shadowsocks over websocket (HTTP)

Warning: HTTP only provides a moderate (but lightweight) traffic obfuscation. Cautious users should refrain from using this mode.

On your server

```sh
ss-server -c config.json -p 80 --plugin v2ray-plugin --plugin-opts "server"
```

On your client

```sh
ss-local -c config.json -p 80 --plugin v2ray-plugin
```

### Shadowsocks over websocket (HTTPS)

On your server

```sh
ss-server -c config.json -p 443 --plugin v2ray-plugin --plugin-opts "server;tls;host=mydomain.me"
```

On your client

```sh
ss-local -c config.json -p 443 --plugin v2ray-plugin --plugin-opts "tls;host=mydomain.me"
```

### Shadowsocks over quic

On your server

```sh
ss-server -c config.json -p 443 --plugin v2ray-plugin --plugin-opts "server;mode=quic;host=mydomain.me"
```

On your client

```sh
ss-local -c config.json -p 443 --plugin v2ray-plugin --plugin-opts "mode=quic;host=mydomain.me"
```

### Issue a cert for TLS and QUIC

`v2ray-plugin` will look for TLS certificates signed by [acme.sh](https://github.com/acmesh-official/acme.sh) by default.
Here's some sample commands for issuing a certificate using CloudFlare.
You can find commands for issuing certificates for other DNS providers at acme.sh.

```sh
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --issue --dns dns_cf -d mydomain.me
```

Alternatively, you can specify path to your certificates using option `cert` and `key`.

### Use `certRaw` to pass certificate

Instead of using `cert` to pass the certificate file, `certRaw` could be used to pass in PEM format certificate, that is the content between `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` without the line breaks.

## Deploy to AWS EC2/Lightsail (using docker)
1. Create an AWS EC2/Lightsail server, connect and open a cmd shell.
2. `sudo yum -y install docker`
3. `sudo systemctl enable docker`
4. `sudo systemctl start docker`
5. `sudo docker run -e PASSWORD=<YOUR_PASSWORD> -e METHOD=chacha20-ietf-poly1305 -p 80:443 -d --restart always --name ss flikas/shadowsocks-webapp`
6. Check: `docker ps`, `docker logs ss`
7. Setup client: 
    - Server Address: `Your server public ip`
    - Server Port: `80`
    - Encryption: `chacha20-ietf-poly1305`
    - Plugin: `v2ray-plugin.exe`
    - Plugin Args: `path=/api`