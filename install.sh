apt update
apt upgrade -y

wget "https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh"
chmod +x install-release.sh
./install-release.sh
rm install-release.sh

default_ID="f00b4045-fe9e-4b9e-aa37-7da4e0ee2dfd"
read -p "请输入ID [默认：$default_ID]: " user_input

if [[ -z "$user_input" ]]; then
    echo "{\"log\":{\"loglevel\":\"warning\"},\"routing\":{\"domainStrategy\":\"AsIs\",\"rules\":[{\"type\":\"field\",\"ip\":[\"geoip:private\"],\"outboundTag\":\"block\"}]},\"inbounds\":[{\"listen\":\"0.0.0.0\",\"port\":80,\"protocol\":\"vmess\",\"settings\":{\"clients\":[{\"id\":\"$default_ID\"}]},\"streamSettings\":{\"network\":\"ws\",\"security\":\"none\"}}],\"outbounds\":[{\"protocol\":\"freedom\",\"tag\":\"direct\"},{\"protocol\":\"blackhole\",\"tag\":\"block\"}]}" > config.json
else
    echo "{\"log\":{\"loglevel\":\"warning\"},\"routing\":{\"domainStrategy\":\"AsIs\",\"rules\":[{\"type\":\"field\",\"ip\":[\"geoip:private\"],\"outboundTag\":\"block\"}]},\"inbounds\":[{\"listen\":\"0.0.0.0\",\"port\":80,\"protocol\":\"vmess\",\"settings\":{\"clients\":[{\"id\":\"$user_input\"}]},\"streamSettings\":{\"network\":\"ws\",\"security\":\"none\"}}],\"outbounds\":[{\"protocol\":\"freedom\",\"tag\":\"direct\"},{\"protocol\":\"blackhole\",\"tag\":\"block\"}]}" > config.json
fi

rm install.sh

v2ray run -c config.json