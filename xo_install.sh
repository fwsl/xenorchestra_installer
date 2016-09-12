#!/bin/bash
sudo apt-get update
sudo apt-get install --yes nfs-common git curl npm build-essential redis-server libpng12-dev git python-minimal
cd /opt
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install --yes nodejs
curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
sudo chmod +x /usr/local/bin/n
sudo n stable
git clone -b stable https://github.com/vatesfr/xo-server
git clone -b stable https://github.com/vatesfr/xo-web
cd xo-server
sudo npm install && npm run build
sudo cp sample.config.yaml .xo-server.yaml
sudo sed -i /mounts/a\\"    '/': '/opt/xo-web/dist'" .xo-server.yaml
sudo npm install xo-server-transport-email
sudo npm install xo-server-backup-reports
cd /opt/xo-web
sudo npm install
sudo npm run build
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

sudo chmod +x /etc/systemd/system/xo-server.service
sudo systemctl enable xo-server.service
sudo systemctl start xo-server.service
