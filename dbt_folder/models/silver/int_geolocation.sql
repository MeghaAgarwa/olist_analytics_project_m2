with geolocation as (
    select * from {{ref('stg_geolocation')}}
)

select 
    lpad(
        cast(geolocation_zip_code_prefix as text),
        5,
        '0'
    ) as geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    initcap(trim(geolocation_city)) as geolocation_city,
    upper(trim(geolocation_state)) as geolocation_state
from geolocation