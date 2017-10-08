# -*- coding: utf-8 -*-
"""
Created on Sun Oct 08 17:21:27 2017

@author: kohei-mu
"""

import numpy as np
from sklearn.decomposition import MiniBatchDictionaryLearning
import pandas as pd
from sklearn.decomposition import SparseCoder
import matplotlib.pyplot as plt
import seaborn as sns

#f=open("toy.csv", "r")
def file_reader(csv):
    df=pd.read_csv(csv,header=0)
    return df
#data=file_reader(f).iloc[:,2]

train=df.iloc[:,1][0:100]
test=df.iloc[:,1][101:201]

dico = MiniBatchDictionaryLearning(n_components=500, alpha=1, n_iter=1000,transform_algorithm = 'lasso_lars',transform_alpha=1.0, fit_algorithm = 'lars')  
V = dico.fit(train).components_

coder = SparseCoder(dictionary=V, transform_algorithm='omp', transform_n_nonzero_coefs=10)
u = coder.transform(test)
reconstruction = np.dot(u, V)

fig = plt.figure()
plt.plot(train)
fig = plt.figure()
plt.plot(test)
fig = plt.figure()
plt.plot(reconstruction[0])

residual=(reconstruction[0]-test)**2
fig = plt.figure()
plt.plot(residual)

fig = plt.figure()
sns.distplot(residual)
