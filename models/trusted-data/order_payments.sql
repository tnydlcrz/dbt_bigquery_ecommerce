{{ config(materialized="table") }}

SELECT
    ORDER_ID
  , PAYMENT_SEQUENTIAL
  , UPPER(TRIM(PAYMENT_TYPE)) AS PAYMENT_TYPE
  , PAYMENT_INSTALLMENTS
  , PAYMENT_VALUE
FROM {{ source('ecommerce_raw', 'order_payments') }}
WHERE ORDER_ID IS NOT NULL