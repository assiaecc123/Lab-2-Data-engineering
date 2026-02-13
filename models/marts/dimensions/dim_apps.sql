{{ config(materialized='table') }}

with apps as (
    select * from {{ ref('stg_playstore_apps') }}
)

select
    app_id,           -- The unique ID for each app
    app_name,
    category,
    rating,
    reviews_count,
    installs,
    developer
from apps