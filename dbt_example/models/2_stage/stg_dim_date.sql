{{ config(
    tags=["dimension","dim_date"]
) }}

with source_data as (
    -- This refers to the table created from data/business_dates.csv
    select * 
    from {{ ref('business_dates') }}
)

select *
from source_data