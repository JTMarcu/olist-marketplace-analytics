with customers as (
    -- Get distinct customers and their most recent location
    select distinct
        customer_id, -- Staging renamed 'customer_unique_id' to this
        last_value(zip_code) over (partition by customer_id order by customer_id) as zip_code,
        last_value(city) over (partition by customer_id order by customer_id) as city,
        last_value(state) over (partition by customer_id order by customer_id) as state
    from {{ ref('stg_customers') }}
),

metrics as (
    select * from {{ ref('int_customer_history') }}
)

select
    c.customer_id as customer_unique_id,
    c.zip_code,
    c.city,
    c.state,
    m.first_order_date,
    m.last_order_date,
    m.total_orders,
    m.total_item_revenue,
    m.total_freight_paid,
    m.current_state as most_recent_order_state
from customers c
left join metrics m on c.customer_id = m.customer_unique_id