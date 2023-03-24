with product as(
    select 
        p.product_id, p.product_name, count(oi.order_id) as orders, rank() over (order by orders desc) as order_rank
    from BIKE_SHOP_PREPERATION.prep_products as p left join BIKE_SHOP_PREPERATION.order_items as oi
    on p.product_id=oi.product_id group by p.product_id, p.product_name order by orders desc
)

select
    product_id,
    product_name,
    orders as total_orders,
    case
        when total_orders=max(total_orders) then 'best_product'
        when total_orders=min(total_orders) then 'least_product'
    end as "best and least products"
from product where order_rank=max(order_rank) and order_rank=min(order_rank)