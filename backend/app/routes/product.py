from __future__ import unicode_literals
from flask import Blueprint, request
from app.helpers.response import response_ok, response_error


product_routes = Blueprint('product', __name__)


@product_routes.route('/', methods=['GET'])
def product_list():
    """
    " get products
    "
    """
    try:
        return response_ok()
    except Exception as ex:
        return response_error(ex)
