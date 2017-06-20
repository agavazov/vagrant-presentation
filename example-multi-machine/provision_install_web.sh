yum install epel-release -y
yum install nodejs -y
yum install supervisor -y

npm install -g redis

systemctl enable supervisord

cat > /etc/supervisord.d/web.ini <<EOL
[program:web]
environment=NODE_PATH=/usr/lib/node_modules/
command=node server.js
directory=/vagrant/src/
autostart=true
autorestart=true
startretries=5
user=vagrant
EOL

systemctl restart supervisord
