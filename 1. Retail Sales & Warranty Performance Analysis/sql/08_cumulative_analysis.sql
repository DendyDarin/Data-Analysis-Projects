/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
    total_quantity,
    SUM(total_quantity) OVER (ORDER BY order_date) AS running_total_quantity,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
    SELECT 
        DATETRUNC(year, sale_date) AS order_date,
        SUM(quantity) AS total_quantity,
        SUM(CAST(revenue AS bigint)) AS total_sales
    FROM ars.sales
    GROUP BY DATETRUNC(year, sale_date)
) t
