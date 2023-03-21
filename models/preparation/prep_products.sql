{{
  config(
    materialized='table'
  )
}}

with product as(
    select
        CAST(product_id as VARCHAR) as product_id,
        CAST(product_name as VARCHAR) as product_name,
        CAST(brand_id as VARCHAR) as brand_id,
        CAST(category_id as VARCHAR) as category_id,
        list_price,
        CAST(model_year as VARCHAR) as model_year
    from dbt_exercise.bike_shop.products
)

select * from product