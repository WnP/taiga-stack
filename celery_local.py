from .celery import *  # noqa

# To use celery in memory
# task_always_eager = True
broker_url = "amqp://taiga:secret@tasks.rabbitmq:5672/celery"
result_backend = 'redis://tasks.redis:6379/0'
