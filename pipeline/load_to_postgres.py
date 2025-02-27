#load_to_postgres.py
from sqlalchemy import create_engine

def load_to_postgres(df, db_url, table_name):
    engine = create_engine(db_url)
    try:
        df.to_sql(table_name, engine, if_exists='replace', index=False)
        print(f"Data successfully loaded into the {table_name} table.")
    except Exception as e:
        print(f"Error loading data into PostgreSQL: {e}")
