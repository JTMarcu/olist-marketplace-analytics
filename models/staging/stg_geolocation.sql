with source as (
    select * from {{ source('olist', 'geolocation') }}
),

aggregated as (
    select
        geolocation_zip_code_prefix as zip_code,
        geolocation_city as city,
        geolocation_state as state,
        
        -- Calculate the "Center" of the zip code to avoid duplicates
        avg(geolocation_lat) as lat,
        avg(geolocation_lng) as lng

    from source
    group by 1, 2, 3
)

select * from aggregated