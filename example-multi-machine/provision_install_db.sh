yum install epel-release -y
yum install redis -y
sed -i '/^bind 127.0.0.1/s/^bind/#bind/' /etc/redis.conf
systemctl enable redis
systemctl start redis
