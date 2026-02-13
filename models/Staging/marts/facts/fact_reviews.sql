{{ config(materialized='table') }}

select
    r.review_id,
    r.app_id,
    -- Connect to our date dimension
    cast(strftime(cast(r.review_date as date), '%Y%m%d') as integer) as review_date_key,
    r.rating,
    r.thumbs_up
from {{ ref('stg_playstore_reviews') }} r