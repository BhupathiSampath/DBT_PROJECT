with store_revenue as(
    select s.store_id, s.store_name, sum(oi.revenue) as revenue
    from BIKE_SHOP_PREPERATION.prep_store as s left join BIKE_SHOP_PREPERATION.prep_orders as o
    on s.store_id=o.store_id left join BIKE_SHOP_PREPERATION.order_items as oi on 
    o.order_id=oi.order_id
    group by s.store_id, s.store_name order by revenue desc
)

select * from store_revenue