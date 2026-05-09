with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
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
