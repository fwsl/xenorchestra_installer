#!/bin/bash
WORKDIR=/opt
xowebDIR="$WORKDIR"/xo-web
xoserverDIR="$WORKDIR"/xo-server


if [ -d "$xowebDIR" ]; then
    printf '%s\n' "Creating backup of ($xowebDIR)"
    tar -zcf "$WORKDIR"/xo-web-$(date +%Y.%m.%d-%H:%M:%S).tar.gz "$xowebDIR"
    printf '%s\n' "Removing old ($xowebDIR)"
    rm -rf "$xowebDIR"
fi
if [ -d "$xoserverDIR" ]; then
    printf '%s\n' "Creating backup of ($xoserverDIR)"
    tar -zcf "$WORKDIR"/xo-server-$(date +%Y.%m.%d-%H:%M:%S).tar.gz "$xoserverDIR"
    printf '%s\n' "Removing old ($xoserverDIR)"
    rm -rf "$xoserverDIR"
fi

apt-get update
apt-get install --yes curl
cd "$WORKDIR"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install --yes nodejs
apt-get install --yes nfs-common git npm build-essential redis-server libpng12-dev git python-minimal

curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
chmod +x /usr/local/bin/n
n stable
git clone -b stable https://github.com/vatesfr/xo-server
git clone -b stable https://github.com/vatesfr/xo-web
cd "$xoserverDIR"
npm set progress=false
npm install && npm run build
cp sample.config.yaml .xo-server.yaml
sed -i /mounts/a\\"    '/': '/opt/xo-web/dist'" .xo-server.yaml
npm install xo-server-transport-email
npm install xo-server-backup-reports
cd "$xowebDIR"
npm install && npm run build 
cat > /etc/systemd/system/xo-server.service <<EOF
# systemd service for XO-Server.

[Unit]
Description= XO Server
After=network-online.target

[Service]
WorkingDirectory=/opt/xo-server/
ExecStart=/usr/local/bin/node ./bin/xo-server
Restart=always
SyslogIdentifier=xo-server

[Install]
WantedBy=multi-user.target
EOF

chmod +x /etc/systemd/system/xo-server.service
systemctl enable xo-server.service
systemctl start xo-server.service
