WITH brand AS(
    SELECT 
        CAST(brand_name AS VARCHAR) AS brand_name,
        CAST(brand_id AS VARCHAR) AS brand_id
    FROM {{ source('training','brands')}}
)

SELECT * FROM brand