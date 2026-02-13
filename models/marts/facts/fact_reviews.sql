{{ config(materialized='table') }}

with reviews as (
    select * from {{ ref('stg_playstore_reviews') }}
),

-- This internal reference is what creates the arrow in your graph!
dates as (
    select * from {{ ref('dim_date') }}
)

select
    r.review_id,
    r.app_id,
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up
from reviews r
-- We don't necessarily need to join it here to create the arrow, 
-- but having the 'ref' in the CTE above will draw the line.