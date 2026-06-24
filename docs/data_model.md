# Gold Layer Data Model

## Overview

The Gold layer provides analytics-ready tables designed to support business reporting, semantic consistency, and dashboard consumption.

The data model follows a star schema approach with clearly defined fact and dimension tables.

The design is driven by the reporting requirements of two primary personas:

* Executive Leadership
* Business Data Analysts

---

## Star Schema

```text
                 dim_date
                     |
                     |
dim_customers -- fact_orders  -- dim_products
                     |
                     |
                dim_sellers
```

---

## Fact Tables

### fct_sales

**Purpose:** Supports sales, customer, product, seller, payment, review, and delivery performance analysis.

**Grain:** One row per `order_id` and `order_item_id`.

**Primary Key:** `sales_sk`

**Business Key:** Composite key (`order_id`, `order_item_id`)

| Column                 | Description                                                 |
| ---------------------- | ----------------------------------------------------------- |
| `sales_sk`             | Surrogate key generated from `order_id` and `order_item_id` |
| `order_id`             | Order identifier                                            |
| `order_item_id`        | Line item number within the order                           |
| `customer_id`          | Customer identifier                                         |
| `product_id`           | Product identifier                                          |
| `seller_id`            | Seller identifier                                           |
| `order_date`           | Foreign key to `dim_date`                                   |
| `order_status`         | Current order status                                        |
| `price`                | Item price                                                  |
| `freight_value`        | Freight cost allocated to the item                          |
| `gross_revenue`        | Sum of `price` and `freight_value`                          |
| `total_payment_value`  | Total payment amount associated with the order              |
| `payment_installments` | Number of payment installments                              |
| `payment_count`        | Number of payment records associated with the order         |
| `average_review_score` | Average customer review score for the order                 |
| `review_sentiment`     | Derived review sentiment classification                     |
| `delivery_days`        | Number of days between purchase and delivery                |
| `is_late_delivery`     | Indicates whether delivery exceeded the estimated date      |

### Supported Metrics

* Total Revenue
* Total Orders
* Average Order Value
* Average Review Score
* Delivery Time
* Late Delivery Rate
* Revenue by Category
* Revenue by Seller
* Payment Installment Analysis
* Freight Cost
* Repeat Customer Rate

---

## Dimension Tables

### dim_date

**Purpose:** Supports all time-based analysis.

**Grain:** One row per calendar date.

**Primary Key:** `date_key`

| Column         | Description           |
| -------------- | --------------------- |
| `date_key`     | Calendar date         |
| `year`         | Calendar year         |
| `quarter`      | Quarter number        |
| `month_number` | Month number          |
| `month_name`   | Month name            |
| `week_number`  | ISO week number       |
| `day_of_month` | Day of month          |
| `day_of_week`  | ISO day of week (1–7) |
| `day_name`     | Day name              |
| `is_weekend`   | Weekend indicator     |

**Notes:**

* `dim_date` is dynamically generated using PostgreSQL `generate_series()`.
* The date range starts from January 1 of the year containing the earliest order date(2016) to 2021.
* The date range extends few years beyond the latest order date to support forecasting.

---

### dim_customers

**Purpose:** Supports customer and geographic analysis.

**Grain:** One row per customer.

**Primary Key:** `customer_unique_id`

| Column                     | Description                            |
| -------------------------- | -------------------------------------- |
| `customer_unique_id`       | Unique Customer identifier             |
| `customer_city`            | Customer city                          |
| `customer_state`           | Customer state                         |

---

### dim_products

**Purpose:** Supports product and category analysis.

**Grain:** One row per product.

**Primary Key:** `product_id`

| Column                       | Description                   |
| ---------------------------- | ----------------------------- |
| `product_id`                 | Product identifier            |
| `product_category`           | Translated product category   |
| `product_weight_g`           | Product weight in grams       |
| `product_length_cm`          | Product length in centimeters |
| `product_height_cm`          | Product height in centimeters |
| `product_width_cm`           | Product width in centimeters  |

---

### dim_sellers

**Purpose:** Supports seller performance and geographic analysis.

**Grain:** One row per seller.

**Primary Key:** `seller_id`

| Column                   | Description            |
| ------------------------ | ---------------------- |
| `seller_id`              | Seller identifier      |
| `seller_city`            | Seller city            |
| `seller_state`           | Seller state           |

---



