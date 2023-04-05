with staffs AS(
    SELECT 
        STAFF_ID,
        FIRST_NAME,
        LAST_NAME,
        EMAIL,
        PHONE,
        ACTIVE,
        STORE_ID,
        MANAGER_ID
    FROM {{ source('training','staff') }}
), final AS(
    SELECT 
        cast(staff_id AS varchar) AS staff_id,
        cast(store_id AS varchar) AS store_id,
        cast(manager_id AS varchar) AS manager_id,
        first_name,
        last_name,
        email,
        phone
    FROM staffs
)

SELECT * FROM final