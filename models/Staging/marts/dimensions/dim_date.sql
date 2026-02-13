{{ config(materialized='table') }}

with date_spine as (
    select 
        cast(range as date) as date_day
    from range(cast('2024-01-01' as date), cast('2026-12-31' as date), interval '1 day')
)

select
    cast(strftime(date_day, '%Y%m%d') as integer) as date_key,
    date_day as full_date,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    strftime(date_day, '%B') as month_name,
    extract(day from date_day) as day
from date_spine