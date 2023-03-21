SELECT
  SUM(list_price*quantity) AS total_revenue_before_discount,
  SUM(list_price*quantity * discount) AS total_discounted_amount,
  SUM(list_price*quantity * (1 - discount)) AS total_revenue_after_discount,
  COUNT(*) AS total_orders
FROM
  BIKE_SHOP_PREPERATION.order_items