with delivery as(
    select 
        p.product_id,
        p.product_name,
        avg(o.delivery_days) as delivery_days
    from BIKE_SHOP_PREPERATION.prep_products as p left join BIKE_SHOP_PREPERATION.order_items as oi on p.product_id=oi.product_id
    left join BIKE_SHOP_PREPERATION.prep_orders as o on oi.order_id=o.order_id where o.order_status=4
    group by p.product_id, p.product_name, o.delivery_days
)

select * from delivery