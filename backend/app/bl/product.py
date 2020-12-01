#!/usr/bin/python
# -*- coding: utf-8 -*-
from flask import g

import base64


def generate_auth_header_value():
    key = base64.b64encode(
        bytes(g.MIDTRANS_SERVER_KEY, 'utf-8'))
    return "Basic {}".format(key.decode("ascii"))


def prepare_headers(json=True):
    header = {}
    if json:
        header["Content-Type"] = "application/json"
    header["Accept"] = "application/json"
    header["Authorization"] = generate_auth_header_value()
    return header
