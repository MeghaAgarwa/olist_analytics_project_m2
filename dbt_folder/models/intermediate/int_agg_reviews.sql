with reviews as (
    select * from {{ref('int_reviews')}}
),
aggregated as (
    select 
        order_id,
        avg(review_score)::numeric(3,2) as average_review_score
    from reviews
    group by order_id
)

select 
    order_id,
    average_review_score,
    case
        when average_review_score >= 4 then 'Positive'
        when average_review_score = 3 then 'Neutral'
        else 'Negative'
    end as review_sentiment

from aggregated