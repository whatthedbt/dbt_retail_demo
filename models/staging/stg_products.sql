with source as(
select * from {{ source('retail_src', 'products') }}
),

renamed as (
    select product_id,
    category_id, 
    product_name,
    price,
    {{ cents_to_dollars('price')}} as product_price
    from source
)

select * from renamed