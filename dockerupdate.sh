#!/bin/bash


#added from loop brnachy


docker pull ghcr.io/linuxserver/jackett > /tmp/dockerpull.tmp
cat /tmp/dockerpull.tmp
if [[ `grep Downloaded /tmp/dockerpull.tmp` ]] ; then
    docker stop jackett
    docker rm jackett
    docker run -d --name=jackett -e PUID=1000 -e PGID=1000 -e TZ=Europe/Amsterdam -e AUTO_UPDATE=true -p 9117:9117 -v /f/docker/configs/jackett:/config -v /f/Downloads/torrents/backhole:/downloads --restart unless-stopped ghcr.io/linuxserver/jackett
fi

docker pull ghcr.io/linuxserver/nzbhydra2 > /tmp/dockerpull.tmp
cat /tmp/dockerpull.tmp
if [[ `grep Downloaded /tmp/dockerpull.tmp` ]] ; then
   docker stop nzbhydra2
   docker rm nzbhydra2
   docker run -d --name=nzbhydra2 -e PUID=1000 -e PGID=1000 -e TZ=Europe/Amsterdam -p 5076:5076 -v /f/docker/configs/nzbhydra2/config:/config --restart unless-stopped ghcr.io/linuxserver/nzbhydra2
fi

docker pull pihole/pihole:latest> /tmp/dockerpull.tmp
cat /tmp/dockerpull.tmp
if [[ `grep Downloaded /tmp/dockerpull.tmp` ]] ; then
docker pull pihole/pihole:latest> /tmp/dockerpull.tmp
   docker stop pihole
   docker rm pihole
   docker run -d --name pihole  --net=host -e ServerIP=192.168.178.242 -v "/f/docker/configs/pihole/pihole/:/etc/pihole/" -v "/f/docker/configs/pihole/dnsmasq.d/:/etc/dnsmasq.d/" --cap-add=NET_ADMIN -e WEBPASSWORD=password -e TZ=Europe/Amsterdam -p 80:80/tcp -p 53:53/tcp -p 53:53/udp -p 443:443/tcp -p 67:67/udp --dns=127.0.0.1 --dns=1.1.1.1 --restart=unless-stopped pihole/pihole:latest
fi

docker image prune -f
