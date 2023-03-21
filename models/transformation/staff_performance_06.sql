with staff_perf as(
    select 
        s.staff_id,
        concat(s.first_name,' ', s.last_name) as staff_name,
        case when sum(oi.revenue) is null then 0
        else sum(oi.revenue) end as total_revenue
    from BIKE_SHOP_PREPERATION.prep_staffs as s left join BIKE_SHOP_PREPERATION.prep_orders as o
        on s.staff_id=o.staff_id left join BIKE_SHOP_PREPERATION.order_items as oi on 
        o.order_id=oi.order_id
    group by s.staff_id, staff_name order by total_revenue DESC

)

select *, rank() over (order by total_revenue desc) as staff_rank from staff_perf where total_revenue!=0