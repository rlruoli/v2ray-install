#!/bin/bash

apt update
apt upgrade -y

wget "https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh"
chmod +x install-release.sh
./install-release.sh
rm install-release.sh

if [ -z "$1" ]; then
  Port=80
else
  Port=$1
fi

if [ -z "$2" ]; then
  ID="f00b4045-fe9e-4b9e-aa37-7da4e0ee2dfd"
else
  ID=$2
fi

echo "{\"log\":{\"loglevel\":\"warning\"},\"routing\":{\"domainStrategy\":\"AsIs\",\"rules\":[{\"type\":\"field\",\"ip\":[\"geoip:private\"],\"outboundTag\":\"block\"}]},\"inbounds\":[{\"listen\":\"0.0.0.0\",\"port\":$Port,\"protocol\":\"vmess\",\"settings\":{\"clients\":[{\"id\":\"$ID\"}]},\"streamSettings\":{\"network\":\"ws\",\"security\":\"none\"}}],\"outbounds\":[{\"protocol\":\"freedom\",\"tag\":\"direct\"},{\"protocol\":\"blackhole\",\"tag\":\"block\"}]}" > config.json

rm install.sh

v2ray run -c config.json
