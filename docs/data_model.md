# Gold Layer Data Model

## Overview

The Gold layer provides analytics-ready tables designed to support business reporting, semantic consistency, and dashboard consumption.

The data model follows a star schema approach with clearly defined fact and dimension tables.

The design is driven by the reporting requirements of two primary personas:

* Executive Leadership
* Business Data Analysts

---

## Design Principles

* Each table has a clearly defined grain.
* Metrics are calculated consistently across all dashboards.
* Dimensions support slicing and filtering of business metrics.
* Historical analysis is enabled through a shared date dimension.
* The model prioritizes dashboard performance and ease of use.

---

## Star Schema

```text
                 dim_date
                     |
                     |
dim_customers -- fact_orders -- fact_order_items -- dim_products
                     |
                     |
                dim_sellers
```

---

## Fact Tables

### fact_orders

**Purpose:** Supports order-level, customer-level, and delivery performance analysis.

**Grain:** One row per order.

**Primary Key:** `order_id`

| Column                      | Description                                            |
| --------------------------- | ------------------------------------------------------ |
| order_id                    | Unique order identifier                                |
| customer_id                 | Customer associated with the order                     |
| purchase_date_key           | Foreign key to `dim_date`                              |
| approved_date_key           | Foreign key to `dim_date`                              |
| delivered_date_key          | Foreign key to `dim_date`                              |
| estimated_delivery_date_key | Foreign key to `dim_date`                              |
| order_status                | Current order status                                   |
| order_value                 | Total value of all items in the order                  |
| freight_value               | Total freight cost for the order                       |
| delivery_days               | Days between purchase and delivery                     |
| is_delayed                  | Indicates whether delivery exceeded the estimated date |

**Supported Metrics:**

* Total Orders
* Cancellation Rate
* Average Delivery Time
* Delayed Delivery Rate
* Average Order Value

---

### fact_order_items

**Purpose:** Supports product, category, and seller analysis.

**Grain:** One row per order item.

**Primary Key:** Composite key (`order_id`, `order_item_id`)

| Column            | Description                        |
| ----------------- | ---------------------------------- |
| order_id          | Order identifier                   |
| order_item_id     | Line item number within the order  |
| product_id        | Product identifier                 |
| seller_id         | Seller identifier                  |
| purchase_date_key | Foreign key to `dim_date`          |
| price             | Item price                         |
| freight_value     | Freight cost allocated to the item |

**Supported Metrics:**

* Total Revenue
* Revenue by Category
* Revenue by Seller
* Freight Cost
* Top Products

---

### fact_payments (Optional)

**Purpose:** Supports payment behavior analysis.

**Grain:** One row per payment transaction.

**Primary Key:** Composite key (`order_id`, `payment_sequential`)

| Column               | Description                           |
| -------------------- | ------------------------------------- |
| order_id             | Order identifier                      |
| payment_sequential   | Sequence number for multiple payments |
| payment_type         | Payment method                        |
| payment_installments | Number of installments                |
| payment_value        | Payment amount                        |

**Supported Metrics:**

* Revenue by Payment Method
* Average Installments
* Payment Mix Analysis

---

## Dimension Tables

### dim_date

**Purpose:** Supports all time-based analysis.

**Grain:** One row per calendar date.

**Primary Key:** `date_key`

| Column     | Description                      |
| ---------- | -------------------------------- |
| date_key   | Surrogate key in YYYYMMDD format |
| date       | Calendar date                    |
| day        | Day of month                     |
| week       | Week number                      |
| month      | Month number                     |
| month_name | Month name                       |
| quarter    | Quarter number                   |
| year       | Calendar year                    |
| day_name   | Day of week                      |
| is_weekend | Weekend indicator                |

**Notes:**

`dim_date` is a role-playing dimension.

Multiple foreign keys in fact tables reference the same dimension, including:

* purchase_date_key
* approved_date_key
* delivered_date_key
* estimated_delivery_date_key

---

### dim_customers

**Purpose:** Supports customer and geographic analysis.

**Grain:** One row per customer.

**Primary Key:** `customer_id`

| Column             | Description                            |
| ------------------ | -------------------------------------- |
| customer_id        | Customer identifier                    |
| customer_unique_id | Unique customer across multiple orders |
| customer_city      | Customer city                          |
| customer_state     | Customer state                         |

---

### dim_products

**Purpose:** Supports product and category analysis.

**Grain:** One row per product.

**Primary Key:** `product_id`

| Column            | Description        |
| ----------------- | ------------------ |
| product_id        | Product identifier |
| product_category  | Product category   |
| product_weight_g  | Product weight     |
| product_length_cm | Product length     |
| product_height_cm | Product height     |
| product_width_cm  | Product width      |

---

### dim_sellers

**Purpose:** Supports seller performance analysis.

**Grain:** One row per seller.

**Primary Key:** `seller_id`

| Column       | Description       |
| ------------ | ----------------- |
| seller_id    | Seller identifier |
| seller_city  | Seller city       |
| seller_state | Seller state      |

---

## Metric-to-Table Mapping

| Metric                | Source Table                | Key Dimensions        |
| --------------------- | --------------------------- | --------------------- |
| Total Revenue         | fact_order_items            | Date, Product, Seller |
| Total Orders          | fact_orders                 | Date, Customer        |
| Average Order Value   | fact_orders                 | Date, Customer        |
| Delivery Time         | fact_orders                 | Date, Seller          |
| Delayed Delivery Rate | fact_orders                 | Date, Seller, State   |
| Cancellation Rate     | fact_orders                 | Date                  |
| Freight Cost          | fact_order_items            | Date, Product, Seller |
| Repeat Customer Rate  | fact_orders + dim_customers | Date, Customer        |

---

## Assumptions

* Revenue is calculated as `price + freight_value`.
* Delivery time is calculated as the difference between purchase date and delivered date.
* Delayed orders are defined as orders delivered after the estimated delivery date.
* Repeat customers are identified using `customer_unique_id`.
* Cancelled orders are identified using `order_status = 'canceled'`.

---

## Known Limitations

* Customer demographic information is unavailable.
* Product profitability cannot be calculated due to missing cost data.
* Customer lifetime value is estimated using revenue only.
* Historical changes to product categories and seller attributes are not tracked.
* Forecasting models are based solely on historical order data.

```
```
