{{ config(materialized='view') }}

with source as (
    select * from read_json_auto('raw_data/apps_catalog.json')
),

renamed as (
    select distinct
        appId as app_id,
        title as app_name,  -- This fixes the "app_name not found" error
        genre as category,
        score as rating,
        ratings as reviews_count,
        developer
    from source
)

select * from renamed