with dim_customers as (
    select * from {{ ref('int_customers') }}
)
select
    customer_unique_id,
    min(customer_city) as customer_city,
    min(customer_state) as customer_state
from dim_customers
group by customer_unique_id

