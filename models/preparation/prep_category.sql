WITH category AS(
    SELECT 
        CAST(category_name AS VARCHAR) AS category_name,
        CAST(category_id AS VARCHAR) AS category_id
    FROM {{ source('training','category') }}
)

SELECT * FROM category