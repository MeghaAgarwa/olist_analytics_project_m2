with date_bounds as (

    select
        date_trunc(
            'year',
            min(order_date)
        )::date as start_date,

        (
            date_trunc(
                'year',
                max(order_date)
            )
            + interval '4 years'
            - interval '1 day'
        )::date as end_date

    from {{ ref('int_orders_enriched') }}

),

dates as (

    select
        generate_series(
            start_date,
            end_date,
            interval '1 day'
        )::date as date_key
    from date_bounds

)

select

    date_key,

    extract(year from date_key) as year,

    extract(quarter from date_key) as quarter,

    extract(month from date_key) as month_number,

    trim(to_char(date_key, 'Month')) as month_name,

    extract(week from date_key) as week_number,

    extract(day from date_key) as day_of_month,

    extract(isodow from date_key) as day_of_week,

    trim(to_char(date_key, 'Day')) as day_name,

    extract(isodow from date_key) in (6, 7) as is_weekend

from dates