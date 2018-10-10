#!/bin/sh

rabbitmqctl add_user taiga secret
rabbitmqctl add_vhost taiga
rabbitmqctl set_permissions -p taiga taiga ".*" ".*" ".*"
