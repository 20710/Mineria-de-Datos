#!/usr/bin/env python
# coding: utf-8

# In[20]:


#Primer modelo de clasificación n-dimensional.

from pandas import read_csv
import matplotlib.pyplot as plt
import pandas as pd

from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import OrdinalEncoder
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2
from sklearn.feature_selection import mutual_info_classif
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import numpy as np
from sklearn import linear_model
from sklearn import model_selection
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt
import seaborn as sb


# In[21]:


path = 'usuarios_win_mac_lin.csv'
df = pd.read_csv(path, encoding='latin', error_bad_lines=False)
df.head()


# In[22]:


X = np.array(df.drop(['clase'],1))
y = np.array(df['clase'])
X.shape


# In[25]:


model = linear_model.LogisticRegression()
model.fit(X,y)
predictions = model.predict(X)
a=model.score(X,y)
print('Accuracy/exactitud: %.2f' % (a*100), '%')


# In[26]:



validation_size = 0.20
seed = 7
X_train, X_validation, Y_train, Y_validation = model_selection.train_test_split(X, y, test_size=validation_size, random_state=seed)


# In[27]:


name='Logistic Regression'
kfold = model_selection.KFold(n_splits=10, random_state=seed)
cv_results = model_selection.cross_val_score(model, X_train, Y_train, cv=kfold, scoring='accuracy')
msg = "%s: %f (%f)" % (name, cv_results.mean(), cv_results.std())
print(msg)


# In[28]:


predictions = model.predict(X_validation)
print(accuracy_score(Y_validation, predictions))


# In[ ]:




