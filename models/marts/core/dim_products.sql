with products as (
    select * from {{ ref('stg_products') }}
)

select
    product_id,
    -- Using the clean name from staging
    product_category as category_name,
    weight_g as weight_grams,
    length_cm,
    height_cm,
    width_cm
from products