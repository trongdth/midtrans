#!/bin/bash
python manage.py db upgrade
celery -A app.tasks:celery worker --loglevel=info & python wsgi.py