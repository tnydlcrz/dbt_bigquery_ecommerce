SELECT
    ORDER_ID
  , CUSTOMER_ID
  , UPPER(TRIM(ORDER_STATUS)) AS ORDER_STATUS
  , CAST(DATE_TRUNC(CAST(ORDER_PURCHASE_TIMESTAMP AS DATETIME), DAY) AS DATE) AS ORDER_PURCHASE_TIMESTAMP
  , ORDER_APPROVED_AT
  , ORDER_DELIVERED_CARRIER_DATE
  , ORDER_DELIVERED_CUSTOMER_DATE
  , CAST(DATE_TRUNC(CAST(ORDER_ESTIMATED_DELIVERY_DATE AS DATETIME), DAY) AS DATE) AS ORDER_ESTIMATED_DELIVERY_DATE
FROM {{ source('ecommerce_raw', 'orders') }}
WHERE CUSTOMER_ID IS NOT NULL