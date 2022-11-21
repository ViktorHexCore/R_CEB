# save this as app.py
from flask import Flask
import pickle

myheart = pickle.load(
    open('./PyModelDeployment/model/Logreghearth.pkl', 'rb'))

app = Flask(__name__)


@app.route("/")
def hello():
    return '''
    <body>
        <h2>Hello, World!</h2>
    </body>
    '''
    # return "Hello, World!"


@app.route("/greet/<name>")
def greet(name):
    return "Hello, {}!".format(name)


@app.route("/modelcoef")
def show_model_coef():
    # print("Coef load:", myheart.coef_)
    return "Model Coefficients"
    # + myheart.coef_


if(__name__ == '__main__'):
    HOST = '127.0.0.1'
    PORT = '5000'
    app.run(HOST, PORT)
