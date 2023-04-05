WITH product AS(
    SELECT
        CAST(product_id AS VARCHAR) AS product_id,
        CAST(product_name AS VARCHAR) AS product_name,
        CAST(brand_id AS VARCHAR) AS brand_id,
        CAST(category_id AS VARCHAR) AS category_id,
        list_price,
        CAST(model_year AS VARCHAR) AS model_year
    FROM {{ source('training','products') }}
)

SELECT * FROM product