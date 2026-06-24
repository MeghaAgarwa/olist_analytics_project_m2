with dim_products as (
    select * from {{ ref('int_products') }}
)
select
    product_id,
    product_category,

    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm

from dim_products