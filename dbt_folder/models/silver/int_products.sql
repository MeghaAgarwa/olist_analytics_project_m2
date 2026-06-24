with products as (
    select * from {{ref('stg_products')}}
),

product_category_name_translation as (
    select * from {{ref('stg_product_category_name_translation')}}
)

select 
    p.product_id,
    coalesce(nullif(trim(t.product_category_name_english),''),'Unknown') as product_category,
    p.product_name_length ,
    p.product_description_length ,
    p.product_photos_qty ,
    p.product_weight_g ,
    p.product_length_cm ,
    p.product_height_cm ,
    p.product_width_cm
from products p
left join product_category_name_translation t
on p.product_category_name = t.product_category_name

