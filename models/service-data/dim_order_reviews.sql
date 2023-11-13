{{ config(materialized="table") }}

WITH min_score_reviews AS (
SELECT 
    REVIEW_ID,
	ORDER_ID,
	REVIEW_SCORE,
	REVIEW_COMMENT_TITLE,
	REVIEW_COMMENT_MESSAGE,
	REVIEW_CREATION_DATE,
	REVIEW_ANSWER_TIMESTAMP,
    RANK() OVER(PARTITION BY ORDER_ID ORDER BY REVIEW_SCORE ASC) SCORE_MIN
FROM {{ ref('order_reviews') }}
)
SELECT
    msr.REVIEW_ID,
	msr.ORDER_ID,
	msr.REVIEW_SCORE,
	msr.REVIEW_COMMENT_TITLE,
	msr.REVIEW_COMMENT_MESSAGE,
	msr.REVIEW_CREATION_DATE,
	msr.REVIEW_ANSWER_TIMESTAMP    
FROM min_score_reviews msr
    INNER JOIN {{ ref('dim_time') }} as dt
        ON msr.REVIEW_CREATION_DATE = dt.TIME_DATE
    INNER JOIN {{ ref('dim_time') }} as dt2
            ON msr.REVIEW_ANSWER_TIMESTAMP = dt2.TIME_DATE
WHERE msr.SCORE_MIN = 1 --AND msr.REVIEW_SCORE < 3