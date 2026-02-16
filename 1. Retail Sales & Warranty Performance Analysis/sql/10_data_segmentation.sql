/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH product_segments AS (
    SELECT
        product_id,
        product_name,
        price,
        CASE 
            WHEN price < 500 THEN 'Below 500'
            WHEN price BETWEEN 500 AND 1000 THEN '500-1000'
            WHEN price BETWEEN 1000 AND 1500 THEN '1000-1500'
            ELSE 'Above 1500'
        END AS cost_range
    FROM ars.products
)
SELECT 
    cost_range,
    COUNT(product_id) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;
