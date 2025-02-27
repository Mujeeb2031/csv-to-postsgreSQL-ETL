#main.py
import os
from dotenv import load_dotenv
from load_to_csv import load_csv
from clean_data import clean_data
from load_to_postgres import load_to_postgres



load_dotenv()

def run_pipeline(csv_path, db_url, table_name):
    print("Starting the ETL pipeline...")
    df = load_csv(csv_path)
    if df is not None:
        print(f"CSV file loaded with {len(df)} rows.")
        cleaned_df = clean_data(df)
        load_to_postgres(cleaned_df, db_url, table_name)
    else:
        print("No data to process. Exiting pipeline.")
        
if __name__ == "__main__":
    csv_path = r'C:\Users\mujee\Desktop\csv_to_postgres_ETL\data\Electric_Vehicle_Population_Data.csv'
    db_url = os.getenv('db_url')
    table_name = "electricvehicles"  
    run_pipeline(csv_path, db_url, table_name)
