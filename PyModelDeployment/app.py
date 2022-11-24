# save this as app.py
from flask import Flask, render_template, request
import flask
import pickle
import datetime
import numpy as np

heart = pickle.load(
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
    # return render_template('index.html')


@app.route("/greet/<name>")
def greet(name):
    return "Hello, {}!".format(name)


@app.route("/home")
def home():
    return render_template('index.html', utc_dt=datetime.datetime.utcnow())


@app.route("/page")
def page():
    with open("index.html", 'r') as viz_file:
        return viz_file.read()


@app.route("/modelcoef")
def show_model_coef():
    print("Coef load:", heart.coef_[0][0])
    return "Model Coefficients"
    # + heart.coef_[0][0]


@app.route("/predict", methods=["GET"])
def predict():
    thal = flask.request.args["thal"]
    cp = flask.request.args["cp"]
    slope = flask.request.args["slope"]
    exang = flask.request.args["exang"]
    ca = flask.request.args["ca"]

    fmap = {"normal": [1, 0, 0],
            "fixed defect": [0, 1, 0],
            "reversable defect": [0, 0, 1],
            "typical angina": [1, 0, 0, 0],
            "atypical angina": [0, 1, 0, 0],
            "non anginal pain": [0, 0, 1, 0],
            "asymptomatic": [0, 0, 0, 1],
            "upsloping": [1, 0, 0],
            "flat": [0, 1, 0],
            "downsloping": [0, 0, 1]}

    # X_new = fmap[thal] + fmap[cp] + fmap[slope]

    X_new = np.array(fmap[thal] + fmap[cp] + fmap[slope] +
                     [int(exang)] + [int(ca)]).reshape(1, -1)
    yhat = heart.predict(X_new)
    if yhat[0] == 1:
        outcome = "heart disease"
    else:
        outcome = "normal"
    prob = heart.predict_proba(X_new)

    return "This patient is diagnosed as " + outcome + " with probability " + str(round(prob[0][1], 2))


@app.route("/result", methods=["GET", "POST"])
def result():
    """Gets prediction using the HTML form"""
    if flask.request.method == "POST":
        inputs = flask.request.form
        thal = inputs["thal"]
        cp = inputs["cp"]
        slope = inputs["slope"]
        exang = inputs["exang"]
        ca = inputs["ca"]

    fmap = {"normal": [1, 0, 0],
            "fixed defect": [0, 1, 0],
            "reversable defect": [0, 0, 1],
            "typical angina": [1, 0, 0, 0],
            "atypical angina": [0, 1, 0, 0],
            "non anginal pain": [0, 0, 1, 0],
            "asymptomatic": [0, 0, 0, 1],
            "upsloping": [1, 0, 0],
            "flat": [0, 1, 0],
            "downsloping": [0, 0, 1]}

    X_new = np.array(fmap[thal] + fmap[cp] + fmap[slope] +
                     [int(exang)] + [int(ca)]).reshape(1, -1)
    print(X_new)
    yhat = heart.predict(X_new)
    if yhat[0] == 1:
        outcome = "heart disease"
    else:
        outcome = "normal"
    prob = heart.predict_proba(X_new)
    # results = """
    #           <body>
    #           <h3> Heart Disease Diagnosis <h3>
    #           <p> Patient profile </p>
    #               <h5> Thalassemia: """ + thal + """</h5>
    #               <h5> Chest Pain: """ + cp + """</h5>
    #               <h5> Slope: """ + slope + """</h5>
    #               <h5> Exercise induced angina: """ + exang + """</h5>
    #               <h5> Number of major vessels (0-3) colored by flourosopy: """ + ca + """</h5>
    #           <p> This patient is diagnose as """ + outcome + """ with probability """ + str(round(prob[0][1], 2)) + """.
    #           </body>
    #           """
    results = """
              <body>
              <h3> Heart Disease Diagnosis <h3>
              <p><h4> Patient profile </h4></p>
              <table>
              <tr>
                  <td>Thalassemia: </td>
                  <td>""" + thal + """</td>
              </tr>
              <tr>
                  <td>Chest Pain: </td>
                  <td>""" + cp + """</td>
              </tr>
              <tr>
                  <td>Slope: </td>
                  <td>""" + slope + """</td>
              </tr>
              <tr>
                  <td>Exercise induced angina: </td>
                  <td>""" + exang + """</td>
              </tr>
              <tr>
                  <td>Number of major vessels</td>
                  <td>""" + ca + """</td>
              </tr>
              </table>
              <p> This patient is diagnose as """ + outcome + """ with probability """ + str(round(prob[0][1], 2)) + """.
              </body>"""

    return results


if (__name__ == '__main__'):
    HOST = '127.0.0.1'
    PORT = '5000'
    app.run(HOST, PORT)
