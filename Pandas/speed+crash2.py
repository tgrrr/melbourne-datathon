
# coding: utf-8

# In[1]:


import pandas as pd
import csv
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from pandas.plotting import scatter_matrix
from sklearn import cluster
from scipy import stats  ## for z-score. do we still need it?


# In[2]:


# Read speeds
speeds = pd.read_csv('speeds_processed.csv',sep=",")

speeds.head()


# In[3]:


# Read crash
crashes_ = pd.read_csv('Crashes_Last_Five_Years.csv',sep="	")

crashes_.head()


# In[4]:


speeds = speeds.rename(columns={'Lon': 'LONGITUDE', 'Lat': 'LATITUDE'})


# In[5]:


crashes = crashes_.drop(['X', 'Y', 'OBJECTID', 'ACCIDENT_NO', 'ABS_CODE', 'ACCIDENT_STATUS', 'DCA_CODE', 'NODE_ID','VICGRID_X', 
                        'LGA_NAME_ALL', 'REGION_NAME_ALL', 'RMA', 'RMA_ALL', 'DIVIDED', 'DIVIDED_ALL', 'STAT_DIV_NAME', 'VICGRID_Y', 'DEG_URBAN_NAME','DEG_URBAN_ALL'], axis=1)

del(crashes_)


# In[7]:


#Do a cross join

# speeds['tmp'] = 1
# crashes['tmp'] = 1

# speeds_crashes = pd.merge(speeds, crashes, on=['tmp'])
# speeds_crashes = speeds_crashes.drop('tmp', axis=1)



import itertools

def cartesian(df1, df2):
    rows = itertools.product(df1.iterrows(), df2.iterrows())

    df = pd.DataFrame(left.append(right) for (_, left), (_, right) in rows)
    return df.reset_index(drop=True)

speeds_crashes = cartesian(speeds, crashes)

