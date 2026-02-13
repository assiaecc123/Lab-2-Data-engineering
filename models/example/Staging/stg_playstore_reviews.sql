{{ config(materialized='view') }}

with source as (
    select * from read_json_auto('raw_data/apps_reviews.json')
),

renamed as (
    select
        -- We create a unique ID combining App name and Review text
        md5(concat(App, Translated_Review)) as review_id,
        App as app_name,
        Translated_Review as review_text,
        Sentiment as sentiment,
        Sentiment_Polarity as sentiment_polarity,
        Sentiment_Subjectivity as sentiment_subjectivity
    from source
)

select * from renamed