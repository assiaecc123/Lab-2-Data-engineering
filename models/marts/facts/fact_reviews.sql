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
    a.app_sk, -- Replacing the natural key with the Dimension's Surrogate Key
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up,
    r.review_date
from reviews r
inner join apps_history a 
    on r.app_id = a.app_id -- Using the natural key to retrieve the surrogate key
    and cast(r.review_date as timestamp) >= a.valid_from 
    and (a.valid_to is null or cast(r.review_date as timestamp) < a.valid_to)

{% if is_incremental() %}
  where cast(r.review_date as timestamp) > (select max(cast(review_date as timestamp)) from {{ this }})
{% endif %}