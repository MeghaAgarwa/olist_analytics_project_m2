# SQL Queries Backing Dashboard Visuals

# Dashboard 1 – Executive Sales Performance

## Total Revenue

```
SELECT
    SUM(gross_revenue) AS total_revenue
FROM olist_analytics_gold.fct_sales;
```

---

## Total Orders

```
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_analytics_gold.fct_sales;
```

---


## Repeat Customers

```
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_unique_id
    FROM olist_analytics_gold.fct_sales
    GROUP BY customer_unique_id
    HAVING COUNT(DISTINCT order_id) > 1
) t;
```

---
## Average Order Value

```
SELECT
    SUM(gross_revenue) /
    COUNT(DISTINCT order_id) AS average_order_value
FROM olist_analytics_gold.fct_sales;
```

---

## Repeat Customer Rate

```
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM olist_analytics_gold.fct_sales
    GROUP BY customer_unique_id
)

SELECT
    ROUND(
        100.0 *
        COUNT(CASE WHEN order_count > 1 THEN 1 END)
        / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM customer_orders;
```

---

## Revenue Trend by Month

```sql
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS year_month,
    SUM(total_payment_value) AS monthly_revenue
FROM olist_analytics_gold.fct_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY year_month;
```

---

## Orders Trend by Month

```sql
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS year_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_analytics_gold.fct_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY year_month;
```

---

## Revenue by Product Category

```sql
SELECT
    p.product_category,
    SUM(f.gross_revenue) AS total_revenue
FROM olist_analytics_gold.fct_sales f
JOIN olist_analytics_gold.dim_products p
    ON f.product_id = p.product_id
GROUP BY
    p.product_category
ORDER BY total_revenue DESC;
```

---

## Revenue by Customer State

```sql
SELECT
    c.customer_state,
    SUM(f.gross_revenue) AS revenue
FROM olist_analytics_gold.fct_sales f
JOIN olist_analytics_gold.dim_customers c
    ON f.customer_unique_id = c.customer_unique_id
GROUP BY
    c.customer_state
ORDER BY revenue DESC;
```

---


# Dashboard 2 – Operations & Customer Experience


---

## Total Delivered Orders

```sql
SELECT
    COUNT(DISTINCT order_id) AS delivered_orders
FROM olist_analytics_gold.fct_sales
WHERE order_status = 'delivered';
```

---


## Late Delivery Rate

```sql
SELECT
    ROUND(
        100.0 *
        SUM(CASE WHEN is_late_delivery THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_delivery_rate
FROM olist_analytics_gold.fct_sales
WHERE order_status = 'delivered';
```

---

## Average Review Score

```sql
SELECT
    AVG(average_review_score) AS average_review_score
FROM olist_analytics_gold.fct_sales
WHERE average_review_score IS NOT NULL;
```

---

## Monthly Orders Trend

```sql

SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS year_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_analytics_gold.fct_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY year_month;
```

---

## Average Delivery Days by State

```sql
SELECT
    c.customer_state,
    AVG(f.delivery_days) AS average_delivery_days
FROM olist_analytics_gold.fct_sales f
JOIN olist_analytics_gold.dim_customers c
    ON f.customer_unique_id = c.customer_unique_id
WHERE f.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY average_delivery_days DESC;
```

---

## Average Freight Cost by State

```sql
SELECT
    c.customer_state,
    AVG(f.freight_value) AS average_freight_cost
FROM olist_analytics_gold.fct_sales f
JOIN olist_analytics_gold.dim_customers c
    ON f.customer_unique_id = c.customer_unique_id
GROUP BY
    c.customer_state
ORDER BY average_freight_cost DESC;
```

---

## Late Delivery Rate by State

```sql
SELECT
    c.customer_state,
    ROUND(
        100.0 *
        SUM(CASE WHEN f.is_late_delivery THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_delivery_rate
FROM olist_analytics_gold.fct_sales f
JOIN olist_analytics_gold.dim_customers c
    ON f.customer_unique_id = c.customer_unique_id
WHERE f.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY late_delivery_rate DESC;
```

---

## Review Score by Late Delivery Status

```sql
SELECT
    CASE
        WHEN is_late_delivery THEN TRUE
        ELSE FALSE
    END AS late_delivery,
    AVG(average_review_score) AS avg_review_score
FROM olist_analytics_gold.fct_sales
WHERE order_status = 'delivered'
GROUP BY late_delivery;
```

---
