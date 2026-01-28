with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select * from {{ ref('stg_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

sellers as (
    select * from {{ ref('stg_sellers') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

-- ⚠️ Critical Step: Aggregate payments to order level first
-- This prevents row duplication (fan-out) when joining to items later
order_payments as (
    select
        order_id,
        sum(payment_value) as total_order_value,
        count(payment_sequential) as payment_count
    from {{ ref('stg_payments') }}
    group by 1
),

joined as (
    select
        -- IDs
        o.order_id,
        o.order_customer_id,
        c.customer_id as customer_unique_id, -- The Real Human ID
        i.product_id,
        i.seller_id,

        -- Dimensions
        o.order_status,
        p.product_category,
        c.state as customer_state,
        s.state as seller_state,

        -- Metrics
        i.price,
        i.freight_value,
        op.total_order_value,

        -- Timestamps
        o.ordered_at,
        o.shipped_at,
        o.delivered_at,
        o.estimated_delivery_at

    from orders o
    -- Left Join: Keep all orders even if they have no items/payments yet
    left join items i on o.order_id = i.order_id
    left join products p on i.product_id = p.product_id
    left join sellers s on i.seller_id = s.seller_id
    left join customers c on o.order_customer_id = c.order_customer_id
    left join order_payments op on o.order_id = op.order_id
)

select * from joined