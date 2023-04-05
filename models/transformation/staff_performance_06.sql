WITH staff_perf AS (
    SELECT 
        S.staff_id,
        CONCAT(S.first_name,' ', S.last_name) AS staff_name,
        CASE WHEN SUM(OI.revenue) IS NULL THEN 0
        ELSE sum(OI.revenue) END AS total_revenue
    FROM {{ ref('dim_staff') }} AS S LEFT JOIN {{ ref('dim_orders') }} AS O
        ON S.staff_id=O.staff_id LEFT JOIN {{ ref('fact_order_items') }} AS OI ON 
        O.order_id=OI.order_id
    GROUP BY S.staff_id, staff_name ORDER BY total_revenue DESC

)

SELECT *, rank() OVER (ORDER BY total_revenue DESC) AS staff_rank FROM staff_perf WHERE total_revenue!=0