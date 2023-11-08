{{ config(materialized="table") }}

SELECT
    SELLER_ID
  , SELLER_ZIP_CODE_PREFIX
  , UPPER(TRIM(SELLER_CITY)) AS SELLER_CITY
  , UPPER(TRIM(SELLER_STATE)) AS SELLER_STATE
FROM {{ source('ecommerce_raw', 'sellers') }}
