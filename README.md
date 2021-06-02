# frp_Docker
# ngrok_Docker
Docker for setup websites, using [**frp**](https://gofrp.org/).


## Start:

1. Install docker-ce:
```
[tcjj3@debian]$ sudo apt install -y curl
[tcjj3@debian]$ curl -fsSL get.docker.com -o get-docker.sh
[tcjj3@debian]$ sudo sh get-docker.sh
[tcjj3@debian]$ sudo groupadd docker
[tcjj3@debian]$ sudo usermod -aG docker $USER
[tcjj3@debian]$ sudo systemctl enable docker && sudo systemctl start docker
```
<br>
<br>

2. Run ngrok_Docker:

```
docker run -d -i -t \
 --restart always \
 --name=frp_website \
 -e SERVER_ADDR=frp.freefrp.net \
 -e SERVER_PORT=7000 \
 -e TOKEN=freefrp.net \
 -e PROTOCOL=http \
 -e SUBDOMAIN=test \
 -e LOCAL_IP=192.168.1.1 \
 -e LOCAL_PORT=80 \
 -p 7400:7400 \
 tcjj3/frp_docker:latest
```
or
```
docker run -d -i -t \
 --restart always \
 --name=frp_website \
 -e SERVER_ADDR=frp.freefrp.net \
 -e SERVER_PORT=7000 \
 -e TOKEN=freefrp.net \
 -e PROTOCOL=http \
 -e CUSTOM_DOMAINS=test.example.com \
 -e LOCAL_IP=192.168.1.1 \
 -e LOCAL_PORT=80 \
 -p 7400:7400 \
 tcjj3/frp_docker:latest
```


In this case, the server is from "[**`Free FRP`**](https://freefrp.net/)", you can [**get `servers` from the site**](https://freefrp.net/).
<br>
<br>

The `PROTOCOL` environment variable is "`http`" (or can be "`httponly`", "`https`", "`https2http`", "`tcp`", "`udp`" or "`unix_domain_socket`").
<br>
<br>

If `PROTOCOL` environment variable is "`http`", just set `SUBDOMAIN` environment variable to the name, or set `CUSTOM_DOMAINS` environment variable to your domain(s).
<br>
<br>

If `PROTOCOL` environment variable is "`tcp`" or "`udp`", your should set `REMOTE_PORT` environment variable instead of "`SUBDOMAIN`" or "`CUSTOM_DOMAINS`" environment variables.
<br>
<br>

If `PROTOCOL` environment variable is "`unix_domain_socket`", your should set `REMOTE_PORT` and `UNIX_PATH` environment variables, instead of "`SUBDOMAIN`", "`CUSTOM_DOMAINS`", "`LOCAL_IP`" or "`LOCAL_PORT`" environment variables.
<br>
<br>

For some examples:
<br>
TCP forward:
```
docker run -d -i -t \
 --restart always \
 --name=frp_website \
 -e SERVER_ADDR=frp.freefrp.net \
 -e SERVER_PORT=7000 \
 -e TOKEN=freefrp.net \
 -e PROTOCOL=tcp \
 -e LOCAL_IP=192.168.1.1 \
 -e LOCAL_PORT=80 \
 -e REMOTE_PORT=6000 \
 -p 7400:7400 \
 tcjj3/frp_docker:latest
```

UDP froward:
```
docker run -d -i -t \
 --restart always \
 --name=frp_website \
 -e SERVER_ADDR=frp.freefrp.net \
 -e SERVER_PORT=7000 \
 -e TOKEN=freefrp.net \
 -e PROTOCOL=udp \
 -e LOCAL_IP=192.168.1.1 \
 -e LOCAL_PORT=53 \
 -e REMOTE_PORT=6000 \
 -p 7400:7400 \
 tcjj3/frp_docker:latest
```

unix_domain_socket froward:
```
docker run -d -i -t \
 --restart always \
 --name=frp_website \
 -e SERVER_ADDR=frp.freefrp.net \
 -e SERVER_PORT=7000 \
 -e TOKEN=freefrp.net \
 -e PROTOCOL=unix_domain_socket \
 -e REMOTE_PORT=6000 \
 -e UNIX_PATH=/var/run/docker.sock \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -p 7400:7400 \
 tcjj3/frp_docker:latest
```
<br>


Finally, the port "`7400`" in the container is the "`frp client admin HTTP UI`" of frp, you can find your "`tunnel remote address`" in this page (such as **http://127.0.0.1:7400/**). If you don't need this port, just remove the `7400 port forward` argument.






