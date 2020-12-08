#!/usr/bin/python
# -*- coding: utf-8 -*-
from flask import jsonify


def response_ok(value=None, message='', code=-1):
    result = {
        'status': 1,
        'message': message,
        'code': code
    }

    if len(message) > 0:
        result['message'] = message

    if value is not None:
        result.update({'data': value})

    return jsonify(result)


def response_error(message='', code=-1, status=0):
    result = {
        'status': status,
        'message': message,
        'code': code
    }

    return jsonify(result)
