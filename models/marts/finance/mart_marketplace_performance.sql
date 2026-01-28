with orders as (
    select * from {{ ref('int_orders_enriched') }}
),

reviews as (
    select * from {{ ref('stg_reviews') }}
),

sellers as (
    select * from {{ ref('dim_sellers') }}
)

select
    o.order_id,
    o.customer_unique_id as customer_id, -- Maps to the 'real' human ID
    o.product_id,
    o.seller_id,
    o.ordered_at as order_purchase_timestamp, -- Maps to clean timestamp name
    o.price,
    o.freight_value,
    o.total_order_value,
    
    -- Seller Info
    s.seller_city,
    s.seller_state,

    -- Review Info
    r.review_score,
    r.review_comment_message,

    -- Calculated Metrics
    -- Uses clean timestamp columns: delivered_at, estimated_delivery_at
    date_diff(o.delivered_at, o.estimated_delivery_at, day) as delivery_delay_days

from orders o
left join sellers s on o.seller_id = s.seller_id
left join reviews r on o.order_id = r.order_id