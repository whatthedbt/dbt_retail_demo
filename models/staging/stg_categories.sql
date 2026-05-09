with source as (
select * from {{ source('retail_src', 'categories') }}
),

renamed as (
    select category_id, 
    department_id as dept_id,
    category_name
    from source
)

select * from renamed


