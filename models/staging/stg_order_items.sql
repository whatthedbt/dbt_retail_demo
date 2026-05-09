with source as(
select * from {{ source('retail_src', 'order_items') }}
),

renamed as (
    select order_item_id,
    order_id,
    product_id,
    quantity,
    cast(unit_price as decimal(16, 2)) as unit_price
    from source
)

select * from renamed