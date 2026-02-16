/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(CAST(sa.revenue AS bigint)) AS total_sales
    FROM ars.sales sa
    LEFT JOIN ars.products p
        ON sa.product_id = p.product_id
    LEFT JOIN ars.category c
        ON p.category_id = c.category_id
    GROUP BY c.category_name
)
SELECT
    category_name,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
