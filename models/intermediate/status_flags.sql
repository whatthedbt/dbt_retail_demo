{# Status Flags: Use CASE WHEN logic to define business statuses, such as marking orders as is_delayed if they haven't shipped within 48 hours.
models/intermediate/int_order_status_flags.sql#}

with orders as (
    select * from {{ source('retail_src', 'orders') }}
),

final as (
    select
        order_id,
        status,
        order_date,
        -- Logic: If it's still processing and > 48 hours old, it's delayed
        case 
            when status = 'PROCESSING' 
                 and datediff('hour', order_date, current_timestamp()) > 48 
            then 1 
            else 0 
        end as is_stale_processing,

        -- Logic: Flag orders placed on the weekend for logistics planning
        case 
            when dayname(order_date) in ('Sat', 'Sun') 
            then 1 
            else 0 
        end as is_weekend_order
    from orders
)

select * from final



