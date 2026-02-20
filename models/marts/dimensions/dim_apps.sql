{{ config(materialized='table') }}

with apps as (
    select * from {{ ref('stg_playstore_apps') }}
)

select
    app_id,
    app_name,
    md5(category) as category_id,
    md5(developer) as developer_id,
    rating,
    reviews_count
from apps