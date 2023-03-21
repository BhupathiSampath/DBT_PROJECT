with revenue as(
    select 
        c.category_name, to_char(date_trunc('month', o.order_date), 'Mon') AS month_name,
        date_part('year', o.order_date) AS year,
        sum(oi.revenue) as revenue from BIKE_SHOP_PREPERATION.prep_category as c 
        left join BIKE_SHOP_PREPERATION.prep_products as p on c.category_id=p.category_id left join 
        BIKE_SHOP_PREPERATION.order_items as oi on p.product_id=oi.product_id left join 
        BIKE_SHOP_PREPERATION.prep_orders as o on oi.order_id=o.order_id
        group by c.category_name, o.order_date
)
select * from revenue