{{ config(materialized='table') }}

select distinct
    md5(developer) as developer_id,
    developer as developer_name
from {{ ref('stg_playstore_apps') }}
where developer is not null