with sellers as (
    select * from {{ ref('int_sellers') }}
)
select
    seller_id,
    seller_city,
    seller_state

from sellers