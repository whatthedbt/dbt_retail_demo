
with source as (
select * from {{ source('retail_src', 'orders') }}
),

deduplicated as (select
        *,
        row_number() over (
            partition by order_id 
            -- generally you should use updated_at, ingested_at, or loaded_at kind of column in order by clause when you try to eliminate rows that is mirror duplicated just use distinct, 
            -- but when id column is duplicated but other value/values different then use row number().
            order by order_id desc 
        ) as row_num
    from source),

final as (
    select order_id,  
    customer_id,
    order_date,
    status as order_status
    from deduplicated
    where row_num = 1
)

select * from final order by order_id