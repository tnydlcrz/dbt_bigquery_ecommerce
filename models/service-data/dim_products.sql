{{ config(materialized="table") }}

SELECT
    p.PRODUCT_ID,
    p.PRODUCT_CATEGORY_NAME,
    p.PRODUCT_NAME_LENGHT,
    p.PRODUCT_DESCRIPTION_LENGHT
FROM {{ ref('products') }} p