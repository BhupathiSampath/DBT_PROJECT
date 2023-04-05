WITH revenue AS(
    SELECT 
        C.category_name, 
        to_char(date_trunc('month', O.order_date), 'Mon') AS month_name,
        date_part('year', O.order_date) ASyear,
        SUM(OI.revenue) AS revenue 
        FROM {{ ref('dim_categories') }} AS C 
        LEFT JOIN {{ ref('dim_products') }} AS P ON c.category_id=P.category_id 
        LEFT JOIN {{ ref('fact_order_items') }} AS OI ON p.product_id=OI.product_id 
        LEFT JOIN {{ ref('dim_orders') }} AS O ON OI.order_id=O.order_id
        GROUP BY C.category_name, O.order_date
)
SELECT * FROM revenue