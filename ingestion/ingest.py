from pathlib import Path
import os

import pandas as pd
from dotenv import load_dotenv
import psycopg2

load_dotenv()

def get_db_connection():
    conn = psycopg2.connect(
        host = os.getenv("DB_HOST"),
        port = os.getenv("DB_PORT"),
        database = os.getenv("DB_NAME"),
        user = os.getenv("DB_USER"),
        password = os.getenv("DB_PASSWORD")
    )
    return conn


PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_RAW_DIR = PROJECT_ROOT / "data"/"raw"

FILES = {
    "customers": "olist_customers_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "products": "olist_products_dataset.csv",
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "order_payments": "olist_order_payments_dataset.csv",
    "order_reviews": "olist_order_reviews_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "product_category_name_translation": "product_category_name_translation.csv"
}


def create_schema(conn):
    cursor = conn.cursor()
    cursor.execute("CREATE SCHEMA IF NOT EXISTS raw;")


def load_table(conn, table_name: str, file_name: str):
    file_path = DATA_RAW_DIR / file_name

    print({DATA_RAW_DIR})

    print(f"Loading {table_name}...")

    with conn.cursor() as cursor:
        cursor.execute(f"TRUNCATE TABLE raw.{table_name};")
    
        with open(file_path,"r",encoding="utf-8") as f:
            cursor.copy_expert(
                sql=f"""
                COPY raw.{table_name}
                        FROM STDIN
                        WITH (
                            FORMAT CSV,
                            HEADER TRUE,
                            DELIMITER ','
                        )
                    """,
                    file=f
                )
    conn.commit()
    print(f"Loaded raw.{table_name}")


def main():
    conn = get_db_connection()
    create_schema(conn)

    for table_name, file_name in FILES.items():
        load_table(conn, table_name, file_name)

    print("\nRaw data ingestion completed successfully.")


if __name__ == "__main__":
    main()