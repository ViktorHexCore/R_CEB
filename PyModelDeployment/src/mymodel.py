import pandas as pd
# import numpy as np
import medml as ml
import pickle

column_names = ["age", "sex", "cp", "trestbps", "chol", "fbs",
                "restecg", "thalach", "exang", "oldpeak", "slope",
                "ca", "thal", "num"]
# use fullpath for url
url = 'C:/Users/P/Desktop/repos/CEB_PyDeployModel/PyModelDeployment/data/processed.cleveland.data'
# url = 'C:/Users/ADAWAS/Desktop/repos/R_CEB/PyModelDeployment/data/processed.cleveland.data'

df = pd.read_csv(url, header=None, names=column_names)

df = df[(df['thal'] != '?') & (df['ca'] != '?')].reset_index(drop=True)


df["Labels"] = df['num'].apply(lambda x: 0 if x == 0 else 1)

features = ['thal', 'exang', 'cp', 'ca', 'slope']

# thal
thal = pd.get_dummies(df["thal"])
thal.columns = ["normal", "fixed defect", "reversable defect"]
df = pd.concat([df, thal], axis=1)

# cp
df['cp'] = df['cp'].map(
    {1: "typical angina", 2: "atypical angina", 3: "non-anginal pain", 4: "asymptomatic"})
cp = pd.get_dummies(df['cp'])
df = pd.concat([df, cp], axis=1)

# slope
df['slope'] = df['slope'].map(
    {1: "upsloping", 2: "flat", 3: "downsloping"})
slope = pd.get_dummies(df['slope'])
df = pd.concat([df, slope], axis=1)

select_features = ["normal", "fixed defect", "reversable defect",
                   "typical angina",  "atypical angina",  "non-anginal pain",  "asymptomatic",
                   "upsloping", "flat", "downsloping", "exang", "ca", "Labels"]

data = df.loc[:, select_features]

features = data.columns.tolist()
features.remove('Labels')

print(df)
print(data)

heart = ml.ai(data=df, features=features, target='Labels', test_size=0.2)

# Serialize your model
print("Coef save:", heart.model.coef_)

# save pokel by pickle
pickle.dump(heart.model, open(
    './PyModelDeployment/model/Logreghearth.pkl', 'wb'))

# try load model
myheart = pickle.load(open('./PyModelDeployment/model/Logreghearth.pkl', 'rb'))
print("Coef load:", myheart.coef_)
