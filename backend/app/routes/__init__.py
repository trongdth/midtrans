from flask import request, g
from app import db
from app.routes.product import product_routes


def init_routes(app):

    @app.route('/')
    def hello():
        return 'API'

    app.register_blueprint(product_routes, url_prefix='/product')
