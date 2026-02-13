{{ config(materialized='table') }}

with apps as (
    select * from {{ ref('stg_playstore_apps') }}
)

select
    app_id,
    app_name,
    category,
    rating,
    reviews_count,
    developer
from apps