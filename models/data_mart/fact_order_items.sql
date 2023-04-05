WITH fact_order_items AS (SELECT  
    PO.order_id, 
    OI.item_id, 
    P.product_id, 
    C.category_id, 
    B.brand_id, 
    PO.store_id, 
    PO.staff_id, 
    PO.customer_id,
    OI.quantity,
    OI.list_price,
    OI.discount,
    OI.total_price,
    OI.revenue
FROM {{ ref('prep_orders') }} AS PO INNER JOIN {{ ref('order_items') }} OI 
ON PO.order_id=OI.order_id INNER JOIN {{ ref('prep_products') }} AS P ON 
OI.product_id=P.product_id INNER JOIN {{ ref('prep_category') }} AS C 
ON P.category_id=C.category_id INNER JOIN  {{ ref('prep_brand') }} AS B 
ON P.brand_id = B.brand_id)
SELECT  * FROM fact_order_items