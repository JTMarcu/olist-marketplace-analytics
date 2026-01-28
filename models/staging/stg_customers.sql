with source as (

    select * from {{ source('olist', 'customers') }}

),

renamed as (

    select
        -- Primary Keys
        -- Note: In Olist, 'customer_id' is actually a temporary ID per order.
        -- 'customer_unique_id' is the real human being.
        customer_id as order_customer_id,
        customer_unique_id as customer_id, 

        -- Location Details
        customer_zip_code_prefix as zip_code,
        customer_city as city,
        customer_state as state

    from source

)

select * from renamed