with sellers as (
    select * from {{ ref('stg_sellers') }}
)

select
    seller_id,
    -- Using clean names from staging
    city as seller_city,
    state as seller_state,
    zip_code as seller_zip_code_prefix
from sellers