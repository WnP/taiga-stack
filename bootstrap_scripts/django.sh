#!/bin/sh

chown -R django /usr/django/app/media
python manage.py migrate --noinput
python manage.py loaddata initial_user
python manage.py loaddata initial_project_templates
python manage.py compilemessages
# python manage.py sample_data  # only if you want some demo data
python manage.py collectstatic --noinput
