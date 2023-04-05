WITH product AS(
    select 
        p.product_id, p.product_name, COUNT(oi.order_id) AS orders, RANK() OVER (ORDER BY orders DESC) AS order_rank
    FROM {{ ref('dim_products') }} AS p left join {{ ref('fact_order_items') }} AS oi
    ON p.product_id=oi.product_id GROUP BY p.product_id, p.product_name ORDER BY orders DESC
),

cte AS (
  SELECT MIN(order_rank) AS min_number, MAX(order_rank) AS max_number
  FROM product
),
final AS (
    SELECT 
        product_id, 
        product_name, 
        orders AS total_orders,
        order_rank
    FROM product
    WHERE order_rank = (SELECT min_number FROM cte)
    OR order_rank = (SELECT max_number FROM cte)
)

select 
    product_id, 
    product_name,
    total_orders,
    CASE
        WHEN order_rank = 1 THEN 'Best Product'
        ELSE 'Least product'
    END AS "best and least products"
    FROM final