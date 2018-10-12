#!/bin/sh

rabbitmqctl add_user taiga secret
rabbitmqctl add_vhost taiga
rabbitmqctl set_permissions -p taiga taiga ".*" ".*" ".*"
# Celery
rabbitmqctl add_vhost celery
rabbitmqctl set_permissions -p celery taiga ".*" ".*" ".*"
