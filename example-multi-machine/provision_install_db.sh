yum install epel-release -y
yum install redis -y
sed -i '/^bind 127.0.0.1/s/^bind/#bind/' /etc/redis.conf
sed -i '/^protected-mode yes/s/^protected-mode yes/protected-mode no/' /etc/redis.conf
systemctl enable redis
systemctl start redis
