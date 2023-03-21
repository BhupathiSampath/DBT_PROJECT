{{
  config(
    materialized='table'
  )
}}

with order_item as(
    select
        CAST(order_id as VARCHAR)  as order_id,
        CAST(product_id as VARCHAR)  as product_id,
        CAST(item_id as VARCHAR)  as item_id,
        discount,
        quantity,
        list_price,
        (quantity*list_price) as total_price,
        total_price-(total_price*discount) as revenue
    from dbt_exercise.bike_shop.order_items
)

select * from order_item