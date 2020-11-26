import os
from datetime import timedelta


class BaseConfig(object):
    ENV = 'DEV'
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    BASE_URL = ''

    # SQLALCHEMY
    SQLALCHEMY_COMMIT_ON_TEARDOWN = True
    SQLALCHEMY_DATABASE_URI = 'mysql://root:@localhost/db?charset=utf8mb4'
    DATABASE_CONNECT_OPTIONS = {'charset': 'utf8mb4'}
    SQLALCHEMY_TRACK_MODIFICATIONS = True

    # JWT
    JWT_AUTH_USERNAME_KEY = 'email'
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(days=60)
    JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=120)
    SECRET_KEY = ''

    REDIS_HOST = 'localhost'
    REDIS_PORT = 6379
    CELERY_BROKER_URL = 'redis://%s:%s/0' % (REDIS_HOST, REDIS_PORT)
    CELERY_RESULT_BACKEND = 'redis://%s:%s/0' % (REDIS_HOST, REDIS_PORT)
    MIDTRANS_SERVER_KEY = ''


class DevelopmentConfig(BaseConfig):
    SQLALCHEMY_DATABASE_URI = 'mysql://root:@localhost/db?charset=utf8mb4'
