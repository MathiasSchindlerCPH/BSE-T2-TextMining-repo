import json
from twarc_csv import DataFrameConverter
from twarc.expansions import ensure_flattened
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


## %% EXTRACTING HASHTAGS:

# What is the problem? Look how entities look like:

df['entities.hashtags']

# We need some transformations to extract the tag:


def hash_retrieve(df):
    """
    df : dataframe of tweets
    Description: 
        The function takes as an object a df of tweets obtained via twarc and 
        returns a generator object.
    
    """

    for line, id in zip(df['entities.hashtags'], df['id']):
        if pd.isna(line):
            continue
        line = line.strip()
        data = json.loads(line)
        for hashtag in ensure_flattened(data):
            #print(hashtag['tag'],id)
            yield [hashtag['tag'], id]


hash_retrieve(df)
# Using the generator to create a new dataframe.
a = pd.DataFrame(list(hash_retrieve(df)),
                 columns=['hashtag', 'id'])


# Grouping hashtags by a list.
a.groupby('id')['hashtag'].apply(lambda x: ','.join(x))


## %% EMOJIS:

#df = pd.read_csv(my_path+"/sample.csv")
# -*- coding: UTF-8 -*-
s = '😊'

print(s.encode('unicode-escape').decode('ASCII'))

print(u'\U0001f60a')


"""
Emojis work as any normal word in a query. They can just be added to it and 
twarc will back up tweets containing them


In mac run "locale" to check supported formats 
twarc2 search --archive --limit 10 "😊 -is:retweet -is:reply lang:en" | twarc2 text
"""


# From emojis to text: (p set activity)


#
#
#
