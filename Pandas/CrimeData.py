
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


# Read crime data
crimedata = pd.read_csv('Data_tables_Criminal_Incidents_Visualisation_year_ending_March_2018.csv')
crimedata.head()


# # Process the data

# In[3]:


crimedata['Incidents Recorded'] = crimedata['Incidents Recorded'].str.replace(',', '')
crimedata['Incidents Recorded'] = crimedata['Incidents Recorded'].apply(pd.to_numeric)

crimedata.dtypes


# In[4]:


# Sort offenses by Offence Division to identify targeted crimes that take place in public

crimedata['Offence Division'].value_counts()


# In[5]:


mask_public = crimedata.isin({'Offence Division': ['A Crimes against the person','D Public order and security offences']}).any(1)
crimedata = crimedata.loc[mask_public]

crimedata.head()


# In[6]:


crimedata['Offence Division'].value_counts()


# In[7]:


# Sort offenses by Offence Subdivision to identify targeted crimes that are targeted at a person(s)

crimedata['Offence Subdivision'].value_counts()


# In[8]:


mask_targeted = ~crimedata.isin({'Offence Subdivision': ['A50 Robbery','Weapons and explosives offences', 'Other crimes against the person']}).any(1)
crimedata = crimedata.loc[mask_targeted]

crimedata.head()


# In[9]:


crimedata['Offence Subdivision'].value_counts()


# In[10]:


# Sort offenses by Offence Subgroup to identify that are of non domestic in nature

crimedata['Offence Subgroup'].value_counts()


# In[11]:


crimedata[['Offence Subgroup Code', 'Offence Subgroup Name']] = crimedata['Offence Subgroup'].str.split(' ', n=1, expand = True)


# In[12]:


crimedata.head()


# In[13]:


mask_nondomestic = ~crimedata.isin({'Offence Subgroup Code': ['A231', 'A211', 'A731', 'A711', 'A721' ]}).any(1)
crimedata = crimedata.loc[mask_nondomestic]


# In[14]:


crimedata['Offence Subgroup'].value_counts()


# In[15]:


# Remove any other offenses that are not relevant

mask_irrelevant = ~crimedata.isin({'Offence Subgroup Code': ['D12', 'D11', 'A22', 'D25', 'A82', 'D33', 'D43', 'D31', 'D44'
                                                            ,'D41', 'D34', 'D42']}).any(1)
crimedata = crimedata.loc[mask_irrelevant]


# In[16]:


crimedata['Offence Subgroup'].value_counts()


# # Calculate weights for each crime based on severity

# In[17]:


# Function to calculate severity of crime. The severity is out of 10.

def crime_severity (row):
    if row['Offence Subgroup Code'] == 'A212' :
        return 10
    if row['Offence Subgroup Code'] == 'A232' :
        return 10
    if row['Offence Subgroup Code'] == 'D22' :
        return 4
    if row['Offence Subgroup Code'] == 'A89' :
        return 7
    if row['Offence Subgroup Code'] == 'D23' :
        return 5
    if row['Offence Subgroup Code'] == 'A732' :
        return 7
    if row['Offence Subgroup Code'] == 'D35' :
        return 4
    if row['Offence Subgroup Code'] == 'A712' :
        return 10
    if row['Offence Subgroup Code'] == 'A83' :
        return 7
    if row['Offence Subgroup Code'] == 'D24' :
        return 3
    if row['Offence Subgroup Code'] == 'A722' :
        return 8
    if row['Offence Subgroup Code'] == 'A81' :
        return 7
    if row['Offence Subgroup Code'] == 'D21' :
        return 6
    if row['Offence Subgroup Code'] == 'D13' :
        return 6
    if row['Offence Subgroup Code'] == 'D26' :
        return 5
    if row['Offence Subgroup Code'] == 'D32' :
        return 7
    if row['Offence Subgroup Code'] == 'D36' :
        return 7
    if row['Offence Subgroup Code'] == 'D49' :
        return 7


# In[18]:


crime_processed = crimedata.copy(deep=True)

crime_processed['Crime Severity'] = crime_processed.apply (lambda row: crime_severity (row),axis=1)

crime_processed.head()


# In[19]:


# Select most recent crime data from 2018

crime_processed = crime_processed.loc[(crime_processed['Year ending March'] == 2018)]
crime_processed.head()


# In[20]:


# Function to calculate severity score per postcode. 

def severity_score (row):
    return row['Incidents Recorded'] * row['Crime Severity']


# In[21]:


crime_processed['Severity Total Score'] = crime_processed.apply (lambda row: severity_score (row),axis=1)
crime_processed.head()


# In[22]:


crime_processed['Year ending March'].value_counts()


# In[23]:


crime_processed['Suburb/Town Name'].value_counts()


# In[24]:


crime_processed['Offence Division'].value_counts()


# In[25]:


crime_processed['Offence Subdivision'].value_counts()


# In[26]:


crime_processed['Incidents Recorded'].value_counts()


# In[27]:


crime_processed['Offence Subgroup Code'].value_counts()


# In[28]:


crime_processed['Offence Subgroup Name'].value_counts()


# In[29]:


crime_processed['Crime Severity'].value_counts()


# In[30]:


crime_processed.drop(['Year ending March','Suburb/Town Name','Offence Division','Offence Subdivision',
                      'Incidents Recorded','Offence Subgroup Code','Offence Subgroup Name','Crime Severity'], axis=1, inplace=True, errors='raise')


# In[31]:


crime_processed = crime_processed.groupby(['Postcode'], as_index=False).agg({'Severity Total Score':sum})


# In[32]:


crime_processed.head()


# In[33]:


crime_processed[crime_processed.duplicated(keep=False)].sort_values(by=['Postcode'])


# # Join with postcodes to get average gps position of each postcode

# In[34]:


# Read postcode data
postcode_loc = pd.read_csv('Australian_Post_Codes_Lat_Lon.csv')
postcode_loc.head()


# In[35]:


postcode_loc.shape


# In[36]:


postcode_loc = postcode_loc.groupby(['postcode'], as_index=False).mean()
postcode_loc.head()


# In[37]:


postcode_loc[postcode_loc.duplicated(keep=False)].sort_values(by=['postcode'])


# In[43]:


crime_processed = crime_processed.set_index('Postcode').join(postcode_loc.set_index('postcode'))


# In[44]:


crime_processed.reset_index()


# In[ ]:


crime_processed.to_csv('crimes_weighted.csv', index=False)

