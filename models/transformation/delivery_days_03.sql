with delivery AS(
    SELECT 
        P.product_id,
        P.product_name,
        AVG(O.delivery_days) AS delivery_days
    FROM {{ ref('dim_products') }} AS P left join {{ ref('fact_order_items') }} AS OI ON P.product_id=oi.product_id
    left join {{ ref('dim_orders') }} AS O ON OI.order_id=O.order_id WHERE O.order_status=4
    GROUP BY P.product_id, p.product_name, o.delivery_days
)

SELECT * FROM delivery