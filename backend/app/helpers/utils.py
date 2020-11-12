#!/usr/bin/python
# -*- coding: utf-8 -*-

import re


def is_valid_email(email):
    if email is not None:
        email = email.lower()
        if re.match("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,6})$", email) != None:
            p = email.split('@')
            if p[1] is not None and p[1] not in ['spam4.me', 'pokemail.net', 'guerrillamailblock.com', 'guerrillamail.org', 'guerrillamail.net', 'guerrillamail.de', 'guerrillamail.com', 'guerrillamail.biz', 'grr.la', 'guerrillamail.info', 'sharklasers.com', 'yopmail.com', 'nopemail.me', 'maildrop.cc', 'proove.org', 'izolrom.ro', 'voltaer.com', 'shayzam.net', 'yevme.com', 'opayq.com', 'emailna.co', 'tuta.io', 'getnada.com', 'moruzza.com', 'mailhex.com', 'radiodale.com', 'datasoma.com', 'providier.com', 'cliptik.net', 'plutofox.com', 'lagify.com', 'khtyler.com', 'shayzam.ne', 'geroev.net', 'nando1.com', 'zdfpost.net', 'tempmail.ws']:
                return True
    return False
