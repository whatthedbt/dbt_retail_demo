-- Order Enrichment: Join stg_orders with stg_order_items and stg_products 
-- to calculate the total value of each order at the line-item level.

with orders as (
    select * from {{ source('retail_src', 'orders') }}
),

items as (
    select * from {{ source('retail_src', 'order_items') }}
),

products as (
    select * from {{ source('retail_src', 'products') }}
),

enriched as (
    select
        items.order_item_id,
        items.order_id,
        orders.customer_id,
        orders.order_date,
        items.product_id,
        products.product_name,
        items.quantity,
        items.unit_price,
        -- The "Line-Item Level" calculation
        (items.quantity * items.unit_price) as item_total_price
    from items
    left join orders on items.order_id = orders.order_id
    left join products on items.product_id = products.product_id
)

select * from enriched
