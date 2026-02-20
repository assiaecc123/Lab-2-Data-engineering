{{ config(
    materialized='incremental',
    unique_key='review_id' 
) }}

with reviews as (
    select * from {{ ref('stg_playstore_reviews') }}
),

apps_history as (
    select * from {{ ref('dim_apps_scd') }}
)

select
    r.review_id,
    r.app_id,
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up,
    r.review_date
from reviews r
-- The True Historical Join:
inner join apps_history a 
    on r.app_id = a.app_id
    -- This ensures we match the review to the app's category exactly as it was on that specific date
    and r.review_date >= a.valid_from 
    and (a.valid_to is null or r.review_date < a.valid_to)

{% if is_incremental() %}
  where r.review_date > (select max(review_date) from {{ this }})
{% endif %}