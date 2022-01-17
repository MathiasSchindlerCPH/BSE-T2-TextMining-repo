import json
from twarc_csv import DataFrameConverter
import pandas as pd
from twarc_csv import dataframe_converter
from twarc_csv import CSVConverter, DataFrameConverter
_
"""
Author: luisigmenendez@gmail.com
Code example on how to get the hashtags from tweets. We make use of the annotations
rather than operating with the text itself. 
To operate on a simple example do this:
    1) cd a directory where you want to store some tweets
    2) Run a random sample with twarc:
    twarc2 sample >sample.jsonl
    3) Remember to execute the previous twarc code, otherwise it keeps running. 
    4) Use the function below to operate with a csv

"""


my_path = "/Users/luisignaciomenendezgarcia/MEGA/Portatil_mega/class_twitter_bse/slides_2/code"

# Default options for Dataframe converter
converter = DataFrameConverter()
data = []
with open(my_path+"/sample.jsonl") as f:
    for line in f:
        data.append(json.loads(line))
df = converter.process(data)
df.head()

## %% DATES


def date_time(df, date_column, replace, place):
   import datetime
   from datetime import datetime
   import dateutil
   from dateutil import tz
   import pytz
   #from_zone = tz.gettz('UTC')
   #to_zone = tz.gettz(place)
   df[date_column] = pd.to_datetime( df[date_column], format="%Y-%m-%dT%H:%M:%S.000Z") 
   if replace == 'yes':
      df[date_column] = df[date_column].dt.tz_localize(pytz.utc) 
      df[date_column] = df[date_column].dt.tz_convert(place)
   # Tell the datetime object that it's in UTC time zone since # datetime objects are 'naive' by default
   elif replace=='no' :
      df['date_new'] = df[date_column].dt.tz_localize(pytz.utc) 
      df['date_new'] = df['date_new'].dt.tz_convert(place)
      




date_time(df,'created_at','no','America/New_York')   

df[['date_new','created_at']]

import datetime
from datetime import datetime
import dateutil
from dateutil import tz
import pytz
from_zone = tz.gettz('UTC')
from_zone

to_zone = tz.gettz(place)
df['created_at'].head()
df['created_at'] = pd.to_datetime( df['created_at'], format="%Y-%m-%dT%H:%M:%S.000Z") 

df['created_at'].dt.tz_localize(pytz.utc) 