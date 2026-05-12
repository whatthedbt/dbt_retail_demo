with source as(
    
    select * from {{ source('retail_src', 'customers') }}
),

renamed as (
    select customer_id,
    customer_name,
    {{coalesce_null(email, default)}} as customer_email,
    state as state_code
    from source
)

select * from renamed