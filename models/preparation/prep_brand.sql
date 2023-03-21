{{
  config(
    materialized='table'
  )
}}

with brand as(
    select 
        CAST(brand_name AS VARCHAR) as brand_name,
        CAST(brand_id AS VARCHAR) as brand_id
    from dbt_exercise.bike_shop.brands
)

select * from brand