FROM rabbitmq:3.6-alpine

# Install and setup supervisor
RUN apk add --no-cache supervisor

COPY ./supervisor/rabbitmq.ini /etc/supervisor.d/
COPY ./supervisor/rabbitmq.setup.ini /etc/supervisor.d/

# You should mount your rabbitmq script in /run/rabbitmq-setup.sh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf", "-n"]
