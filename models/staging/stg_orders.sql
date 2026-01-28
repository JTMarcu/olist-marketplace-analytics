with source as (

    select * from {{ source('olist', 'orders') }}

),

renamed as (

    select
        -- Primary Key
        order_id,

        -- Foreign Keys
        customer_id as order_customer_id, -- Renamed to avoid confusion with unique customer

        -- Status & Dimensions
        order_status,

        -- Timestamps (Standardized to _at suffix)
        cast(order_purchase_timestamp as timestamp) as ordered_at,
        cast(order_approved_at as timestamp) as approved_at,
        cast(order_delivered_carrier_date as timestamp) as shipped_at,
        cast(order_delivered_customer_date as timestamp) as delivered_at,
        cast(order_estimated_delivery_date as timestamp) as estimated_delivery_at

    from source

)

select * from renamed