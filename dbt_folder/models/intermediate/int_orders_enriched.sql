with order_items as (
    select * from {{ ref('int_order_items') }}
),
orders as (
    select * from {{ ref('int_orders') }}
),
customers as (
    select * from {{ ref('int_customers') }}
),
products as (
    select * from {{ ref('int_products') }}
),
sellers as (
    select * from {{ ref('int_sellers') }}
),
payments as (
    select * from {{ ref('int_payments') }}
),
agg_reviews as (
    select * from {{ ref('int_agg_reviews') }}
)
select
    oi.order_id,
    oi.order_item_id,

    cast(o.order_purchase_timestamp as date) as order_date,
    o.order_status,
    o.delivery_days,
    o.is_late_delivery,

    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,

    oi.product_id,
    p.product_category,

    oi.seller_id,
    s.seller_city,
    s.seller_state,

    oi.price,
    oi.freight_value,
    oi.price + oi.freight_value as gross_revenue,

    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    pay.total_payment_value,
    pay.payment_installments,
    pay.payment_count,

    r.average_review_score,
    r.review_sentiment

from order_items oi

left join orders o
    on oi.order_id = o.order_id

left join customers c
    on o.customer_id = c.customer_id

left join products p
    on oi.product_id = p.product_id

left join sellers s
    on oi.seller_id = s.seller_id

left join payments pay
    on oi.order_id = pay.order_id

left join agg_reviews r
    on oi.order_id = r.order_id



        