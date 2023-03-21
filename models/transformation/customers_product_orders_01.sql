with cust_orders as (
    select 
        c.customer_id, 
        case 
            when min(o.order_date) = max(o.order_date) then count(distinct(oi.product_id))
            else count(distinct(oi.product_id)) / nullif(datediff(month, min(o.order_date), max(o.order_date)), 0) 
        end as monthly_orders,
        case 
            when min(o.order_date) = max(o.order_date) then count(distinct(oi.product_id))
            else count(distinct(oi.product_id)) / nullif(datediff(quarter, min(o.order_date), max(o.order_date))/2, 0) 
        end as half_yearly_orders,
        case 
            when min(o.order_date) = max(o.order_date) then count(distinct(oi.product_id))
            else count(distinct(oi.product_id)) / nullif(datediff(year, min(o.order_date), max(o.order_date)), 0) 
        end as yearly_orders,
        count(distinct(product_id)) as total_orders
    from 
        BIKE_SHOP_PREPERATION.prep_customers c 
        join BIKE_SHOP_PREPERATION.prep_orders o on c.customer_id=o.customer_id 
        join BIKE_SHOP_PREPERATION.order_items oi on o.order_id=oi.order_id 
    group by 
        c.customer_id
)

select * from cust_orders