with customer_cohort as (
    select
        c.customer_id,
        min(o.order_date) as first_order_date
    from
        BIKE_SHOP_PREPERATION.prep_customers as c join 
        BIKE_SHOP_PREPERATION.prep_orders as o on c.customer_id=o.customer_id
    group by
        c.customer_id
),

customer_stats as (
    select
        c.customer_id,
        sum(oi.revenue) as total_spent,
        case
            -- when o.order_date >= dateadd(year, -10, max(o.order_date)) then 1
            when o.order_date >= '2018-01-01' then 1
            else 0
        end as is_new_customer
    from
        BIKE_SHOP_PREPERATION.prep_customers as c join BIKE_SHOP_PREPERATION.prep_orders as o 
        on c.customer_id=o.customer_id join order_items as oi on 
        o.order_id=oi.order_id
    group by
        c.customer_id, o.order_date
),

new_customer_stats as (
    select
        sum(total_spent) as new_customer_revenue,
        count(distinct customer_id) as num_new_customers
    from
        customer_stats
    where
        is_new_customer = 1
),

all_customer_stats as (
    select
        sum(total_spent) as total_revenue,
        count(distinct customer_id) as num_customers
    from
        customer_stats
)

select
    num_new_customers , num_customers,
    num_new_customers / cast(num_customers as float) as proportion_new_customers,
    new_customer_revenue ,total_revenue,
    new_customer_revenue / total_revenue as proportion_new_customer_revenue
from
    new_customer_stats
    cross join all_customer_stats