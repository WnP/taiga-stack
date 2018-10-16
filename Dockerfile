FROM python:3.6 as builder

RUN apt-get update \
    && apt-get install -y \
    build-essential binutils-doc autoconf flex bison libjpeg-dev \
    libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev \
    automake libtool libffi-dev curl git tmux gettext \
    libxml2-dev libxslt-dev libssl-dev libffi-dev

COPY ./taiga-back/requirements.txt /build/requirements.txt

RUN pip wheel \
    -r /build/requirements.txt \
    --wheel-dir /build/wheels

################################################################################

FROM registry.orus.io:443/python-django:3.6-slim-1.11

COPY ./taiga-back/requirements.txt /tmp/requirements.txt
COPY --from=builder /build/wheels /tmp/wheels
RUN apt-get update \
    && apt-get install -y \
    flex bison \
    libfreetype6 zlib1g libncurses5 \
    cron curl git gettext libxml2 \
    && pip install -r /tmp/requirements.txt -f /tmp/wheels --no-index \
    && rm -r /tmp/requirements.txt /tmp/wheels \
    && apt-get remove git -y \
    && apt-get clean \
    && apt-get autoclean

COPY ./taiga-back /usr/django/app
RUN mkdir -p /usr/django/app/logs && chown -R django:django /usr/django/app/logs \
    && chown -R django:django /usr/django/app/media
COPY ./taiga-contrib-time-tracking /tmp/taiga-contrib-time-tracking
RUN pip install /tmp/taiga-contrib-time-tracking/back && rm -rf taiga-contrib-time-tracking
COPY ./docker/back/local.py /usr/django/app/settings/local.py
WORKDIR /usr/django/app
# CMD ["python", "manage.py", "runserver"]
CMD ["gunicorn", "-c", "/etc/gunicorn/gunicorn.conf", "--chdir", "/usr/django/app", "--bind", "0.0.0.0:8000", "taiga.wsgi"]
