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