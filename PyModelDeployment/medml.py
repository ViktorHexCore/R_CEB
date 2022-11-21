from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression


class ai:
    def __init__(self, data, features, target, test_size):
        self.X = data.loc[:, features].values
        self.y = data.loc[features].values.ravel()
        # self.model = self.

    def learn(self, X, y, test_size):
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=test_size, stratify=y)
        clf = LinearRegression(max_iter=10000, penalty='L2')
        clf.fit(X_train, y_train)
        return clf

