{{ config(
    materialized='incremental',
    unique_key='review_id' 
) }}
-- We added unique_key so dbt knows how to update existing records without duplicating them[cite: 218].

with reviews as (
    select * from {{ ref('stg_playstore_reviews') }}
),

apps as (
    select app_id from {{ ref('dim_apps') }}
)

select
    r.review_id,
    r.app_id,
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up,
    r.review_date -- We need this column available to check the latest date
from reviews r
inner join apps a 
    on r.app_id = a.app_id

-- Here is the Chaos Engineering logic:
{% if is_incremental() %}

  -- This tells dbt to only load data where the review_date is newer than the maximum date currently in the table[cite: 219].
  where r.review_date > (select max(review_date) from {{ this }})

{% endif %}