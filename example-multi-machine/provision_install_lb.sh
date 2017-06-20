yum install haproxy -y
ln -s /usr/lib/systemd/system/haproxy.service /etc/systemd/system/multi-user.target.wants/haproxy.service

cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original

cat > /etc/haproxy/haproxy.cfg <<EOL
defaults
	mode http
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000
	option forwardfor

frontend http-fe
	bind *:80
	bind *:443 ssl crt /etc/haproxy/ssl/server.pem
	redirect scheme https code 301 if !{ ssl_fc }
	default_backend nodes

backend nodes
	balance roundrobin
	server www-10 web1:80 check
	server www-20 web2:80 check
	#server www-11 web1:8001 check
	#server www-12 web1:8002 check
	#server www-13 web1:8003 check
	#server www-21 web2:8001 check
	#server www-22 web2:8002 check
	#server www-23 web2:8003 check
EOL

mkdir -p /etc/haproxy/ssl/
openssl req -x509 -nodes -days 730 -newkey rsa:2048 -subj '/CN=MonkeyMedia/O=A.Gavazov/C=BG' -keyout /etc/haproxy/ssl/server.key -out /etc/haproxy/ssl/server.crt
cat /etc/haproxy/ssl/server.crt /etc/haproxy/ssl/server.key > /etc/haproxy/ssl/server.pem

systemctl restart haproxy
