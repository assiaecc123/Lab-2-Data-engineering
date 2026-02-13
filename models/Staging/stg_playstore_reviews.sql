{{ config(materialized='view') }}

with source as (
    select * from read_json_auto('raw_data/apps_reviews.json')
),

renamed as (
    select 
        md5(concat(appId, content, "at")) as review_id, -- Added "at" (timestamp) to make the ID more unique
        appId as app_id,
        userName as user_name,
        content as review_text,
        score as rating,
        thumbsUpCount as thumbs_up,
        "at" as review_date,
        -- This ranks duplicates so we can filter them out
        row_number() over (partition by appId, content, "at" order by score desc) as row_num
    from source
)

-- Only keep the first occurrence of any duplicate
select * exclude (row_num)
from renamed
where row_num = 1