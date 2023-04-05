with cust_orders AS (
    SELECT 
        C.customer_id, 
        CASE 
            WHEN min(O.order_date) = max(O.order_date) then COUNT(DISTINCT(OI.product_id))
            ELSE COUNT(DISTINCT(OI.product_id)) / nullif(datediff(month, min(O.order_date), max(O.order_date)), 0) 
        END AS monthly_orders,
        CASE 
            WHEN min(O.order_date) = max(O.order_date) then COUNT(DISTINCT(OI.product_id))
            ELSE COUNT(DISTINCT(OI.product_id)) / nullif(datediff(quarter, min(O.order_date), max(O.order_date))/2, 0) 
        END AS half_yearly_orders,
        CASE 
            WHEN min(O.order_date) = max(O.order_date) then COUNT(DISTINCT(oi.product_id))
            ELSE COUNT(DISTINCT(OI.product_id)) / nullif(datediff(year, min(O.order_date), max(O.order_date)), 0) 
        END AS yearly_orders,
        COUNT(DISTINCT(product_id)) AS total_orders
    FROM 
        {{ ref('dim_customers') }} C 
        JOIN {{ ref('dim_orders') }} O ON c.customer_id=O.customer_id 
        JOIN {{ ref('fact_order_items') }} OI ON O.order_id=OI.order_id 
    GROUP BY 
        c.customer_id
)

SELECT * FROM cust_orders