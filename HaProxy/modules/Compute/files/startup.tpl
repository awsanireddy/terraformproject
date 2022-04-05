#!/bin/sh
wget http://www.haproxy.org/download/2.3/src/haproxy-2.3.4.tar.gz -O ~/haproxy.tar.gz
tar xzvf ~/haproxy.tar.gz -C ~/
cd ~/haproxy-2.3.4
make TARGET=linux-glibc
sleep "100"
sudo make install
sudo mkdir -p /etc/haproxy
sudo mkdir -p /var/lib/haproxy
sudo touch /var/lib/haproxy/stats
sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy
sudo cp ~/haproxy-2.3.4/examples/haproxy.init /etc/init.d/haproxy
sudo chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload
sudo chkconfig haproxy on
sudo useradd -r haproxy
tee /etc/haproxy/haproxy.cfg <<EOF
global
    log                127.0.0.1 local0
    log                127.0.0.1 local1 notice
    user               hapee-lb
    group              hapee
    chroot             /var/empty
    pidfile            /var/run/hapee-1.7/hapee-lb.pid
    stats socket       /var/run/hapee-1.7/hapee-lb.sock user hapee-lb group hapee mode 660 level admin
    stats timeout      10m
    module-path        /opt/hapee-1.7/modules
    daemon
defaults
    mode               http
    log                global
    option             httplog
    option             dontlognull
    option             forwardfor except 127.0.0.0/8
    option             redispatch
    retries            3
    timeout connect    10s
    timeout client     300s
    timeout server     300s
resolvers awsresolve
    nameserver dns1 169.254.169.253:53
    resolve_retries 30
    timeout retry 1s
    hold valid 10s
listen testmirth
        mode tcp
        option tcplog
        bind *:8080
        bind *:8443
        server mirthnlb {ec2lb_arn} check port 8080 resolvers awsresolver
EOF
- systemctl restart hapee-1.7-lb
