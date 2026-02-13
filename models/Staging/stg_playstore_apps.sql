{{ config(materialized='view') }}

with source as (
    -- Reads directly from your raw JSON file
    select * from read_json_auto('raw_data/apps_catalog.json')
),

renamed as (
    select
        -- Mapping your specific JSON keys (appId, title, score, etc.)
        appId as app_id,
        title as app_name,
        summary as summary,
        installs as installs,
        minInstalls as min_installs,
        score as rating,
        ratings as reviews_count,
        price as price,
        free as is_free,
        currency as currency,
        developer as developer,
        developerId as developer_id,
        genre as category,
        released as released_date,
        updated as last_updated,
        version as current_ver
    from source
)

select * from renamed