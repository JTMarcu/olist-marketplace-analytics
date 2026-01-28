with orders as (
    select * from {{ ref('int_orders_enriched') }}
),

agg as (
    select
        customer_unique_id,
        
        -- Lifetime Metrics
        count(distinct order_id) as total_orders,
        sum(price) as total_item_revenue, -- Product revenue only
        sum(freight_value) as total_freight_paid,
        
        -- Recency
        min(ordered_at) as first_order_date,
        max(ordered_at) as last_order_date,
        
        -- Location (Take the most recent state they ordered from)
        -- In BigQuery, array_agg(x limit 1)[offset(0)] is a trick to get "first/last" value
        array_agg(customer_state order by ordered_at desc limit 1)[offset(0)] as current_state

    from orders
    where order_status = 'delivered' -- Only count completed value
    group by 1
)

select * from agg