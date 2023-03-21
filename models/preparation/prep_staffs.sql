{{
  config(
    materialized='table'
  )
}}

with staffs as(
    select 
        STAFF_ID,
        " FIRST_NAME" as FIRST_NAME,
        " LAST_NAME" as LAST_NAME,
        " EMAIL" as EMAIL,
        " PHONE" as PHONE,
        " ACTIVE" as ACTIVE,
        " STORE_ID" as STORE_ID,
        " MANAGER_ID" as MANAGER_ID
    from dbt_exercise.bike_shop.staff
), final as(
    select 
        cast(staff_id as varchar) as staff_id,
        cast(store_id as varchar) as store_id,
        cast(manager_id as varchar) as manager_id,
        first_name,
        last_name,
        email,
        phone
    from staffs
)

select * from final

select * from dbt_exercise.bike_shop.staff