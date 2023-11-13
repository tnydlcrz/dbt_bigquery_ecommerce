{{ config(materialized="table") }}

WITH order_gross_value AS (
SELECT
    ORDER_ID
  , SUM(PRICE) ORDER_GROSS_VALUE
FROM {{ ref('order_items') }}
GROUP BY ORDER_ID
)
SELECT
    o.ORDER_ID
  ,	o.CUSTOMER_ID
  ,	o.ORDER_STATUS
  ,	o.ORDER_PURCHASE_TIMESTAMP
  , o.ORDER_DELIVERED_CUSTOMER_DATE
  , o.ORDER_ESTIMATED_DELIVERY_DATE
  , ogv.ORDER_GROSS_VALUE  
  , oi.ORDER_ITEM_ID
  , oi.PRODUCT_ID
  , oi.SELLER_ID
  , oi.PRICE
  , oi.FREIGHT_VALUE
FROM {{ ref('orders') }} o
    LEFT JOIN {{ ref('order_items') }} oi
        ON o.ORDER_ID = oi.ORDER_ID
    LEFT JOIN order_gross_value ogv
        ON o.ORDER_ID = ogv.ORDER_ID
ORDER BY O.ORDER_ID