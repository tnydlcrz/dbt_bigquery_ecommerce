{{ config(materialized="table") }}

SELECT
    c.customer_id
  , c.customer_unique_id
  , c.customer_zip_code_prefix
  , c.customer_city
  , c.customer_state
  , g.geolocation_lat as customer_geo_lat
  , g.geolocation_lng as customer_geo_lng
  --, row_number() over(partition by c.customer_id order by customer_id) as ord
FROM {{ ref('customers') }} c
      LEFT JOIN {{ ref('geolocation') }} g
          ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
          AND c.customer_state = g.GEOLOCATION_STATE
          AND c.customer_city = g.GEOLOCATION_CITY          
QUALIFY ROW_NUMBER() OVER (PARTITION BY c.CUSTOMER_ID ORDER BY g.GEOLOCATION_LAT, g.GEOLOCATION_LNG DESC) = 1
ORDER BY c.customer_state , c.customer_city