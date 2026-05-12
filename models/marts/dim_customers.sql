with customers as (
    select * from {{ source('retail_src', 'customers') }}
),

customer_snapshots as (
    select * from {{ ref('customer_snapshot') }}
),

final as (
    select
        c.customer_id,
        c.customer_name,
        c.email,
        c.state,
        s.first_order_date,
        s.last_active_date,
        s.total_lifetime_orders,
        
        -- Segmenting the customer (Business Logic)
        case 
            when s.total_lifetime_orders >= 4 then 'VIP'
            when s.total_lifetime_orders >= 1 then 'Active'
            else 'Prospect'
        end as customer_segment,

        
    from customers c
    left join customer_snapshots s on c.customer_id = s.customer_id
)

select * from final
