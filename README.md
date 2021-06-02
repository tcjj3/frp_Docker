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


In this case, the server is from "[**`Free FRP`**](https://freefrp.net/)", you can [**get `servers` from the site**](https://freefrp.net/).
<br>
<br>

