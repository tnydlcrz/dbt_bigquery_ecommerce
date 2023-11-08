{{ config(materialized="table") }}

WITH calendario AS (
SELECT 
  DATE_ADD(CURRENT_DATE(), INTERVAL -num DAY) TIME_DATE
FROM UNNEST(GENERATE_ARRAY(0, 365*10)) AS num
)
SELECT
    TIME_DATE
  , EXTRACT(YEAR from TIME_DATE) AS TIME_YEAR
  , CONCAT(EXTRACT(YEAR from TIME_DATE), '-', EXTRACT(QUARTER from TIME_DATE)) AS TIME_QUARTER
  , SUBSTRING(CAST(DATE_TRUNC(TIME_DATE, MONTH) AS STRING), 1, 7) TIME_MONTH  
FROM calendario