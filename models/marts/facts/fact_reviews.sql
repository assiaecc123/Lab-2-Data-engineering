{{ config(materialized='table') }}

with reviews as (
    select * from {{ ref('stg_playstore_reviews') }}
),

apps as (
    select app_id from {{ ref('dim_apps') }}
),

dates as (
    select * from {{ ref('dim_date') }} -- Just for lineage
)

select
    r.review_id,
    r.app_id,
    -- Create the integer date key (e.g., 20230101)
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up
from reviews r
-- INNER JOIN acts as the filter. 
-- If an app_id isn't in dim_apps, this review will be dropped.
inner join apps a 
    on r.app_id = a.app_id