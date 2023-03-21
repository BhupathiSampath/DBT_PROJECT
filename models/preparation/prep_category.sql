{{
  config(
    materialized='table'
  )
}}

with category as(
    select 
        CAST(category_name AS VARCHAR) as category_name,
        CAST(category_id AS VARCHAR) as category_id
    from dbt_exercise.bike_shop.category
)

select * from category