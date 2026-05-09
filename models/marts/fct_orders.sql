with order_items as (
    select * from {{ ref('int_order_enrichment') }}
),

orders as (
    select * from {{ source('retail_src', 'orders') }}
),


order_totals as (
    select
        order_id,
        sum(item_total_price) as total_revenue,
        count(order_item_id) as total_items_count
    from order_items
    group by 1
)

select
    o.order_id,           -- Primary Key
    o.customer_id,        -- Foreign Key to dim_customers
    o.order_date,
    o.status,
    t.total_revenue,
    t.total_items_count,
    -- Business logic for estimated tax (standard 10%)
    round(t.total_revenue * 0.10, 2) as estimated_tax
from orders o
left join order_totals t on o.order_id = t.order_id
