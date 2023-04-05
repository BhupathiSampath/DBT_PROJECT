WITH ords AS(
    SELECT 
        order_status,
        CAST(customer_id AS  VARCHAR) AS  customer_id,
        CAST(order_id AS  VARCHAR) AS  order_id,
        CAST(store_id AS  VARCHAR) AS  store_id,
        to_date(required_date, 'DD-MM-YYYY') AS  required_date,
        to_date(order_date, 'DD-MON-YY') AS  order_date,
        CASE 
            WHEN shipped_date IS NULL THEN to_date(required_date, 'DD-MM-YYYY')
            ELSE TO_DATE(REPLACE(shipped_date, '.', '-'), 'DD-MM-YY') 
        END AS  shipped_date,
        CAST(staff_id AS  VARCHAR) AS  staff_id,
        datediff(day, to_date(order_date, 'DD-MON-YY'), TO_DATE(REPLACE(shipped_date, '.', '-'), 'DD-MM-YY')) AS  delivery_days
    from {{ source('training','orders') }}
)

SELECT * from ords where order_status!='666'
