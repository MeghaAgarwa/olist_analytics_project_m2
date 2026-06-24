with customers as (
    select * from {{ref('stg_customers') }}
)

select 
    customer_id,
    customer_unique_id,
    lpad(cast(customer_zip_code_prefix as text), 5, '0') as customer_zip_code_prefix,
    initcap(trim(customer_city)) as customer_city,
    upper(trim(customer_state)) as customer_state
from customers