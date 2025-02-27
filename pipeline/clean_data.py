#clean_data.py
import pandas as pd

def clean_data(df):
    df.columns = df.columns.str.strip().str.replace(' ', '_').str.lower()
    df = df.dropna(how='any') 
    for column in df.select_dtypes(include='object').columns:
        df.loc[:, column] = df[column].astype('category')
    
    print("Data cleaned.")
    return df
