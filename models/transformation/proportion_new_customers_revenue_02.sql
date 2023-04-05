with customer_cohort AS (
    SELECT
        C.customer_id,
        min(O.order_date) AS first_order_date
    FROM
        {{ ref('dim_customers') }} AS C join 
        {{ ref('dim_orders') }} AS O ON C.customer_id=O.customer_id
    GROUP BY
        C.customer_id
),

customer_stats AS (
    SELECT
        C.customer_id,
        SUM(OI.revenue) AS total_spent,
        CASE
            WHEN O.order_date >= '2018-01-01' THEN 1
            ELSE 0
        END AS is_new_customer
    FROM
        {{ ref('dim_customers') }} AS C join {{ ref('dim_orders') }} AS O 
        ON C.customer_id=O.customer_id join {{ ref('fact_order_items') }} AS OI ON 
        O.order_id=OI.order_id
    GROUP BY
        C.customer_id, O.order_date
),

new_customer_stats AS (
    SELECT
        sum(total_spent) AS new_customer_revenue,
        count(distinct customer_id) AS num_new_customers
    FROM
        customer_stats
    where
        is_new_customer = 1
),

all_customer_stats AS (
    SELECT
        sum(total_spent) AS total_revenue,
        count(distinct customer_id) AS num_customers
    FROM
        customer_stats
)

SELECT
    num_new_customers , num_customers,
    num_new_customers / cast(num_customers AS float) AS proportion_new_customers,
    new_customer_revenue ,total_revenue,
    new_customer_revenue / total_revenue AS proportion_new_customer_revenue
FROM
    new_customer_stats
    cross join all_customer_stats