Total Revenue KPI
SELECT
    SUM(price + freight_value) AS total_revenue
FROM olist_analytics_gold.fct_sales;


Total Orders KPI
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_analytics_gold.fct_sales;


Total Customers KPI
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM olist_analytics_gold.fct_sales;


Top Product Categories by Revenue
SELECT
    product_category_name,
    SUM(price + freight_value) AS revenue
FROM olist_analytics_gold.fct_sales
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 10;


Revenue by customer state
SELECT
    customer_state,
    SUM(price + freight_value) AS revenue
FROM olist_analytics_gold.fct_sales
GROUP BY customer_state
ORDER BY revenue DESC;


Monthly Revenue Trend
SELECT
    year_month,
    SUM(price + freight_value) AS revenue
FROM olist_analytics_gold.fct_sales
GROUP BY year_month
ORDER BY year_month;


Average Delivery Days by State
SELECT
    customer_state,
    AVG(delivery_days) AS avg_delivery_days
FROM olist_analytics_gold.fct_sales
GROUP BY customer_state;


Average Freight Cost by state
SELECT
    customer_state,
    AVG(freight_value) AS avg_freight_cost
FROM olist_analytics_gold.fct_sales
GROUP BY customer_state;


Orders by Payments Installments
SELECT
    payment_installments,
    COUNT(DISTINCT order_id) AS orders
FROM olist_analytics_gold.fct_sales
GROUP BY payment_installments
ORDER BY payment_installments;


Repeat Customer Rate
WITH repeat_customers AS (
    SELECT customer_unique_id
    FROM olist_analytics_gold.fct_sales
    GROUP BY customer_unique_id
    HAVING COUNT(DISTINCT order_id) > 1
)
SELECT
    COUNT(*) AS repeat_customers
FROM repeat_customers;