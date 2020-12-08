#### Backend:

- virtualenv .venv
- source .venv/bin/activate
- pip install -r requirements.txt
- cp app/settings-default.py app/settings.py
- replace `MIDTRANS_SERVER_KEY` and `MIDTRANS_CLIENT_KEY` with your current key in app/settings.py
- python3 wsgi.py