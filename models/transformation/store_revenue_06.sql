WITH store_revenue AS (
    SELECT S.store_id, S.store_name, sum(OI.revenue) AS revenue
    FROM {{ ref('dim_stores') }} AS S LEFT JOIN {{ ref('dim_orders') }} AS O
    ON S.store_id=O.store_id LEFT JOIN {{ ref('fact_order_items') }} AS OI ON 
    O.order_id=OI.order_id
    GROUP BY S.store_id, S.store_name ORDER BY revenue DESC
)

SELECT * FROM store_revenue