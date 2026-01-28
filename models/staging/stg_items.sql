with source as (
    select * from {{ source('olist', 'items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        
        -- Money columns (Ensure they are numeric/float)
        cast(price as numeric) as price,
        cast(freight_value as numeric) as freight_value,
        
        -- Date
        cast(shipping_limit_date as timestamp) as shipping_limit_at

    from source
)

select * from renamed