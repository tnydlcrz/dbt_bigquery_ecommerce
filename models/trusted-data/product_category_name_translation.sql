{{ config(materialized="table") }}

SELECT
    UPPER(TRIM(PRODUCT_CATEGORY_NAME)) AS PRODUCT_CATEGORY_NAME
  , UPPER(TRIM(PRODUCT_CATEGORY_NAME_ENGLISH)) AS PRODUCT_CATEGORY_NAME_ENGLISH
FROM {{ source('ecommerce_raw', 'product_category_name_translation') }}