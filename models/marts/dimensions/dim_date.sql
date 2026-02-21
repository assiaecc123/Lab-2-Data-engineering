{{ config(materialized='table') }}

with review_dates as (
    select
        cast(min(review_date) as date) as min_date,
        cast(max(review_date) as date) as max_date
    from {{ ref('stg_playstore_reviews') }}
),
date_spine as (
    select cast(range as date) as date_day
    from review_dates,
    range(
        cast(min_date as timestamp),
        cast(max_date + interval '1 day' as timestamp),
        interval '1 day'
    )
)
select
    cast(strftime(date_day, '%Y%m%d') as integer) as date_key,
    date_day as full_date,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    strftime(date_day, '%B') as month_name,
    extract(day from date_day) as day
from date_spine
