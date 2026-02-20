{{ config(materialized='table') }}

with snapshot_data as (
    select * from {{ ref('apps_snapshot') }}
)

select 
    app_id,
    app_name,
    category,
    developer,
    rating,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to,
    -- Create a simple flag to know which row is the active one
    case when dbt_valid_to is null then true else false end as is_current
from snapshot_data