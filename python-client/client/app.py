from flask import Flask
from flask_consulate import Consul


app = Flask(__name__)


@app.route('/healthcheck')
def health_check():
    return '', 200


def main():
    consul = Consul(app=app)
    #consul.apply_remote_config(namespace='mynamespace/')
    consul.register_service(
        name='my-web-app',
        interval='10s',
        tags=['webserver', ],
        httpcheck='http://127.0.0.1:12345/healthcheck',
        address='127.0.0.1',
        port=12345,
    )

    app.run(host='0.0.0.0', port=12345)

if __name__ == '__main__':
    main()
