{#
Customer Snapshots: Calculate customer-level metrics like first_order_date, total_lifetime_orders, and last_active_date.
#}

with orders as (
    select * from {{ source('retail_src', 'orders') }}
),

customer_aggregation as (
    select
        customer_id,
        min(order_date) as first_order_date,    -- The very first purchase
        max(order_date) as last_active_date,   -- The most recent purchase
        count(order_id) as total_lifetime_orders -- Total number of receipts
    from orders
    group by 1
)

select
    c.customer_id,
    c.customer_name,
    a.first_order_date,
    a.last_active_date,
    coalesce(a.total_lifetime_orders, 0) as total_lifetime_orders
from {{ source('retail_src', 'customers') }} c
left join customer_aggregation a on c.customer_id = a.customer_id
