import os

from flask_jwt_extended import JWTManager
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
jwt = JWTManager()

# configure app from env + silent local settings.cfg


def configure_app(app):

    base_dir = os.path.abspath(os.path.dirname(__file__))
    if not os.path.exists(base_dir + "/settings.py"):
        os.rename(base_dir + "/settings-default.py", base_dir + "/settings.py")

    if not os.path.exists(base_dir + "/settings.cfg"):
        os.rename(base_dir + "/settings-default.cfg",
                  base_dir + "/settings.cfg")

    config = {
        "development": "app.settings.DevelopmentConfig",
        "default": "app.settings.DevelopmentConfig"
    }
    config_name = os.getenv('PYTHON_ENV', 'default')
    # object-based default configuration
    app.config.from_object(config[config_name])
    app.config.from_pyfile(os.path.dirname(os.path.realpath(
        __file__)) + '/settings.cfg', silent=True)  # instance-folders configuration
