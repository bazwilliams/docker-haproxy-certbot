#!/bin/sh

/usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg -D -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid)
