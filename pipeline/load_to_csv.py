#load_to_csv.py
import pandas as pd
import os

def load_csv(PATH):
    print(f"Attempting to load file from: {PATH}")
    if not isinstance(PATH, str):
        raise ValueError("The path must be a string.")
    if not PATH.endswith('.csv'):
        raise ValueError("The file must have a '.csv' extension.")
    if os.path.exists(PATH):
        try:
            df = pd.read_csv(PATH)
            print(f"File loaded successfully from: {PATH}")
            return df
        except Exception as e:
            print(f"Error reading the file: {e}")
            return None
    else:
        print(f"The file at {PATH} does not exist.")
        return None