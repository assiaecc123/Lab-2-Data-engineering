{{ config(materialized='view') }}

with source as (
    -- We use DuckDB's magic function to read the JSON directly
    select * from read_json_auto('raw_data/apps_catalog.json')
),

renamed as (
    select
        -- We create a unique ID using the App name
        md5(App) as app_id, 
        App as app_name,
        Category as category,
        Rating as rating,
        Reviews as reviews_count,
        Size as size,
        Installs as installs,
        Type as type,
        Price as price,
        "Content Rating" as content_rating,
        Genres as genres,
        "Last Updated" as last_updated,
        "Current Ver" as current_ver,
        "Android Ver" as android_ver
    from source
)

select * from renamed