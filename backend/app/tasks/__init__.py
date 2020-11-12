from __future__ import unicode_literals
from flask import Flask
from app.factory import make_celery
from app.core import db, configure_app

app = Flask(__name__)
# config app
configure_app(app)

# db
db.init_app(app)

# celery
celery = make_celery(app)