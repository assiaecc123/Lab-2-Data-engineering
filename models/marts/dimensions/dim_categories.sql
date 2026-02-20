{{ config(materialized='table') }}

select distinct
    md5(category) as category_id,
    category as category_name
from {{ ref('stg_playstore_apps') }}
where category is not null