with source as (
select * from {{ source('retail_src', 'departments') }}
),

renamed as (
    select department_id,
    department_name
    from source
)

select * from renamed