{#Category Hierarchy: Join stg_products, stg_categories, 
and stg_departments to create a single product dimension with a clear hierarchy (e.g., Department > Category > Product)#}

with departments as (
    select * from {{ source('retail_src', 'departments') }}
),

categories as(
    select * from {{ source('retail_src', 'categories') }}
),

products as (
    select * from {{ source('retail_src', 'products') }}
),

category_hierarchy as(
    select 
           p.product_name,
           d.department_name,
           c.category_name,
           d.department_name || ' > ' || c.category_name || ' > ' || p.product_name as full_product_path,
           p.price
           from products as p
           left join categories as c on p.category_id = c.category_id
           left join departments as d on d.department_id = c.department_id

)

select * from category_hierarchy