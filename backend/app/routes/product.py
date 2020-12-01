from __future__ import unicode_literals
from flask import Blueprint, request, g
from app.helpers.response import response_ok, response_error
from app.helpers.message import MESSAGE, CODE

import midtransclient
import time

product_routes = Blueprint('product', __name__)


@product_routes.route('/', methods=['GET'])
def product_list():
    """
    " get products
    "
    """
    try:
        return response_ok([
            {
                'id': '1',
                'name': 'Bell Local Helmet',
                'desc': 'Orange Cycling Helmet',
                'image_name': 'orange_helmet',
                'price': '2000'
            },
            {
                'id': '2',
                'name': 'Xiaomi Ninebot',
                'desc': 'Black scooter helmet',
                'image_name': 'unbranded_helmet',
                'price': '2000'
            },
            {
                'id': '3',
                'name': 'Unbranded Helmet',
                'desc': 'Urban cycling helmet',
                'image_name': 'xiaomi_helmet',
                'price': '2000'
            }
        ])
    except Exception as ex:
        return response_error(ex)


@product_routes.route('/purchase', methods=['POST'])
def purchase():
    try:
        data = request.json
        if data is None:
            return response_error(MESSAGE.INVALID_PARAMETER, CODE.INVALID_PARAMETER)

        order_id = 'order_{}_{}'.format(data['product_id'], time.time())
        gross_amount = data['gross_amount']

        print('order_id = {}, gross_amount = {}, midtrans_key = {}'.format(
            order_id, gross_amount, g.MIDTRANS_SERVER_KEY))

        # Create Snap API instance
        snap = midtransclient.Snap(
            # Set to true if you want Production Environment (accept real transaction).
            is_production=False if g.ENV == 'DEV' else True,
            server_key=g.MIDTRANS_SERVER_KEY,
            client_key=g.MIDTRANS_CLIENT_KEY
        )
        # Build API parameter
        param = {
            "transaction_details": {
                "order_id": order_id,
                "gross_amount": gross_amount
            },
        }

        transaction = snap.create_transaction(param)
        transaction_token = transaction['token']
        return response_ok(transaction_token)
    except Exception as ex:
        return response_error(ex.message)
