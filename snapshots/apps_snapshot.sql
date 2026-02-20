{% snapshot apps_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='app_id',
      strategy='check',
      check_cols=['category', 'developer', 'rating'] 
    )
}}

-- This points to your staging model
select * from {{ ref('stg_playstore_apps') }}

{% endsnapshot %}