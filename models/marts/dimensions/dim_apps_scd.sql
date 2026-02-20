{{ config(materialized='table') }}

with snapshot_data as (
    select * from {{ ref('apps_snapshot') }}
)

select 
    dbt_scd_id as app_sk, -- This is the true surrogate key for this specific historical version
    app_id,               -- This is the natural key
    app_name,
    md5(category) as category_id,   -- Maintains the Snowflake hierarchy
    md5(developer) as developer_id, -- Maintains the Snowflake hierarchy
    rating,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to,
    case when dbt_valid_to is null then true else false end as is_current
from snapshot_data