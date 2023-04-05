WITH order_item AS(
    select
        CAST(order_id AS VARCHAR)  AS order_id,
        CAST(product_id AS VARCHAR)  AS product_id,
        CAST(item_id AS VARCHAR)  AS item_id,
        discount,
        quantity,
        list_price,
        (quantity*list_price) AS total_price,
        total_price-(total_price*discount) AS revenue
    FROM  {{ source('training','order_items')}}
)

SELECT  * FROM  order_item