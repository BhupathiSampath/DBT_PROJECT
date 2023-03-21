with store as(
    select 
        cast(store_id as varchar) as store_id,
        store_name,
        email,
        phone,
        city,
        state,
        street
    from dbt_exercise.bike_shop.stores
)

select * from store