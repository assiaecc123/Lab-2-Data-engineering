{{ config(materialized='view') }}

with source as (
    select * from read_json_auto('raw_data/apps_reviews.json')
),

renamed as (
    select distinct
        md5(concat(appId, content)) as review_id,
        appId as app_id,
        userName as user_name,
        content as review_text,
        score as rating,
        thumbsUpCount as thumbs_up,
        "at" as review_date
    from source
)

select * from renamed