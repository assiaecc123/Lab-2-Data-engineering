{{ config(materialized='table') }}

with apps as (
    select * from {{ ref('stg_playstore_apps') }}
)

select
    md5(app_id)            as app_sk,        -- surrogate key (hashed from natural key)
    app_id,                                  -- natural key kept for joining
    app_name,
    md5(category)          as category_id,   -- FK → dim_categories
    md5(developer)         as developer_id,  -- FK → dim_developers
    rating,
    reviews_count
from apps