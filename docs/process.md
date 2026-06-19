models/
├── bronze/
│   ├── src_olist.yml
│   ├── br_customers.sql
│   ├── br_orders.sql
│   ├── br_order_items.sql
│   ├── br_products.sql
│   └── br_sellers.sql
│
├── silver/
│   ├── sl_customers.sql
│   ├── sl_products.sql
│   ├── sl_sellers.sql
│   ├── sl_orders.sql
│   └── sl_order_items.sql
│
└── gold/
    ├── dimensions/
    │   ├── dim_date.sql
    │   ├── dim_customers.sql
    │   ├── dim_products.sql
    │   └── dim_sellers.sql
    │
    └── facts/
        ├── fact_orders.sql
        └── fact_order_items.sql