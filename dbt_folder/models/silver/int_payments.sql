with payments as (
    select * from {{ref('stg_order_payments')}}
)
select
    order_id,
    max(payment_installments) as payment_installments,
    sum(payment_value) as total_payment_value,
    count(*) as payment_count
from payments
group by order_id