WITH stock AS(
    SELECT 
        CAST(product_id AS VARCHAR) AS product_id,
        CAST(store_id AS VARCHAR) AS store_id,
        quantity
    FROM {{ source('training','stocks') }}
)

SELECT * FROM stock

