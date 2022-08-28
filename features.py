import pandas as pd
import numpy as np
import itertools
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler,MinMaxScaler,RobustScaler
from sklearn.cluster import KMeans,DBSCAN
from sklearn.metrics import silhouette_samples, silhouette_score,davies_bouldin_score
from sklearn.decomposition import PCA
from sklearn.base import TransformerMixin


class RuleSelection(TransformerMixin):
    """
        Transformer for selection of features based on a rule using sklearn
         style transform method.  
    """

    def __init__(self, rule=None):
        self.__rule__ = rule
        pass

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        if type(X) == pd.DataFrame:
            features = self.__rule__(X)
            return X.loc[:,features]
        else:
            return X


class FeaturesSelection(TransformerMixin):
    """
        Transformer for manual selection of features using sklearn style transform method.  
    """


    def __init__(self, features=None):
        self.__features__ = features
        pass

    def fit(self, X, y=None):
        return self

    def set_params(self,features):
        self.__features__ = features

    def transform(self, X):
        if type(X) == pd.DataFrame:
            columns = X.columns.values
            features = list(filter(lambda x: x in columns ,self.__features__))
            return X.loc[:,features]
        else:
            return X


class FeaturesScaler(TransformerMixin):
    """
        Transformer for scaling features using sklearn style transform method.  
    """

    def __init__(self, scaler=None):
        self.__scaler__ = scaler
        pass

    def fit(self, X, y=None):
        return self
 
    def set_params(self, scaler):
        self.__scaler__ = scaler

    def transform(self, X):
        if type(X) == pd.DataFrame:
            X_scaled = self.__scaler__.fit_transform(X)
            return pd.DataFrame(X_scaled,columns=X.columns)
        else:
            return self.__scaler__.fit_transform(X)


class LambdaFeatures(TransformerMixin):
    def __init__(self, f=None, features=None):
        self.__f__ = f
        self.__features__ = features 
        pass

    def set_params(self, f):
        self.__f__ = f

    def fit(self, X, y=None):
        return self
 
    def transform(self, X):
        if self.__features__ is None:
            return self.__f__(X)
        else:
            for c in self.__features__:
                if c in X.columns.values:
                    X[c] = self.__f__(X[c])
            return X

class Id:
    def __call__(self, *args):
        return args[0]
    def __repr__(self):
        return "Id"

class Log_plus1:
    def __call__(self, *args):
        return np.log(args[0]+1)
    def __repr__(self):
        return "Log_plus1"

class PCAFeaturesSelection(TransformerMixin):
    """
    Transformer for manual selection of features using sklearn style transform method.  
    """

    def __init__(self, level=0.8):
        self.__level__ = level
        self.__pipe__  = Pipeline([("1",StandardScaler()),("2",PCA())])
        self.__range__ = None
        pass

    def set_params(self, level):
        self.__level__ = level

    def __range_components__(self):
        total = 0
        def below(x):
            nonlocal total 
            total = total+x
            return (total < self.__level__)
        self.__range__ = range(len(list(itertools.takewhile(below,self.__pipe__ [-1].explained_variance_ratio_) )))

    def fit(self, X, y=None):
        self.__pipe__.fit(X)
        self.__range_components__()
        return self
 
    def transform(self, X,y=None):
        X_trans = self.__pipe__.transform(X)
        return X_trans[:,self.__range__]
