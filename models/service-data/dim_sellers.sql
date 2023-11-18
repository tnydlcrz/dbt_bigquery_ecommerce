{{ config(materialized="table") }}

SELECT
    s.seller_id,    
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    g.geolocation_lat as seller_geo_lat,
    g.geolocation_lng as seller_geo_lng
FROM {{ ref('sellers') }} s
      LEFT JOIN {{ ref('geolocation') }} g
          ON s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
          AND s.seller_state = g.GEOLOCATION_STATE
          AND s.seller_city = g.GEOLOCATION_CITY
QUALIFY ROW_NUMBER() OVER (PARTITION BY s.SELLER_ID ORDER BY g.GEOLOCATION_LAT, g.GEOLOCATION_LNG DESC) = 1
--ORDER BY s.seller_state desc , s.seller_city desc