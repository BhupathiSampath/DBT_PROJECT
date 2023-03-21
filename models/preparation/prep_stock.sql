{{
  config(
    materialized='table'
  )
}}

with stock as(
    select 
        cast(product_id as varchar) as product_id,
        cast(store_id as varchar) as store_id,
        quantity
    from dbt_exercise.bike_shop.stocks
)

select * from stock

