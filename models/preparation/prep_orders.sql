{{
  config(
    materialized='table'
  )
}}

with ords AS(
    select 
        order_status,
        CAST(customer_id AS VARCHAR) AS customer_id,
        CAST(order_id AS VARCHAR) AS order_id,
        CAST(store_id AS VARCHAR) AS store_id,
        to_date(required_date, 'DD-MM-YYYY') as required_date,
        to_date(order_date, 'DD-MON-YY') as order_date,
        case 
            when shipped_date is null then to_date(required_date, 'DD-MM-YYYY')
            else TO_DATE(REPLACE(shipped_date, '.', '-'), 'DD-MM-YY') 
        end as shipped_date,
        CAST(staff_id AS VARCHAR) AS staff_id,
        datediff(day, to_date(order_date, 'DD-MON-YY'), TO_DATE(REPLACE(shipped_date, '.', '-'), 'DD-MM-YY')) as delivery_days
    from dbt_exercise.bike_shop.orders
)

select * from ords
