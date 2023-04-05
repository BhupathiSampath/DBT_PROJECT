WITH store AS(
    SELECT 
        CAST(store_id AS varchar) AS store_id,
        store_name,
        email,
        phone,
        city,
        state,
        street
    FROM {{ source('training','stores') }}
)

SELECT * FROM store