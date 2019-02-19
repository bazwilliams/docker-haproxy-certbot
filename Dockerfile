FROM haproxy:1.9-alpine


# Install Supervisor and Certbot
RUN apk add certbot supervisor openssl ca-certificates


# Setup Supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf


# Setup Certbot
RUN mkdir -p /etc/haproxy/certs.d
RUN mkdir -p /etc/letsencrypt
COPY certbot.cron /etc/cron.d/certbot
COPY cli.ini /etc/letsencrypt/cli.ini
COPY haproxy-refresh.sh /usr/bin/haproxy-refresh
COPY haproxy-restart.sh /usr/bin/haproxy-restart
COPY certbot-certonly.sh /usr/bin/certbot-certonly
COPY certbot-renew.sh /usr/bin/certbot-renew
RUN chmod +x /usr/bin/haproxy-refresh /usr/bin/haproxy-restart /usr/bin/certbot-certonly /usr/bin/certbot-renew

# Add startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start
CMD ["/start.sh"]
