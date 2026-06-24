with fct_sales as (
    select * from {{ ref('int_orders_enriched') }}
)
select
    {{ dbt_utils.generate_surrogate_key([
        'order_id',
        'order_item_id'
    ]) }} as sales_sk,

    order_id,
    order_item_id,
    customer_unique_id,
    product_id,
    seller_id,

    order_date,
    order_status,

    price,
    freight_value,
    gross_revenue,

    total_payment_value,

    payment_installments,
    payment_count,

    average_review_score,
    review_sentiment,

    delivery_days,
    is_late_delivery

from fct_sales