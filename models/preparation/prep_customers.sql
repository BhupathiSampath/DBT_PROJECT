WITH cst AS(
    SELECT 
        CAST(customer_id AS VARCHAR) AS customer_id,
        CAST(first_name AS VARCHAR) AS first_name,
        CAST(last_name AS VARCHAR) AS last_name,
        CAST(city AS VARCHAR) AS city,
        CAST(state AS VARCHAR) AS state,
        CAST(zip_code AS VARCHAR) AS zip_code
    FROM {{ source('training','customers') }}
)

SELECT * FROM cst
