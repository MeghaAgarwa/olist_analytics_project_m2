with orders as (
    select * from {{ ref('stg_orders')}}
)

select
    order_id,
    customer_id,
    lower(trim(order_status)) as order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    case
        when order_delivered_customer_date is not null
        then date_part('day',
        order_delivered_customer_date - order_purchase_timestamp) 
    end as delivery_days,
    
    case
        when order_delivered_customer_date is not null
            and order_estimated_delivery_date is not null
            and order_delivered_customer_date > order_estimated_delivery_date
        then true
        when order_delivered_customer_date is not null
            and order_estimated_delivery_date is not null
        then false
    end as is_late_delivery
from orders
