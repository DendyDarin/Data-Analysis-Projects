/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last sale date and the total duration in months
SELECT 
    MIN(sale_date) AS first_sale_date,
    MAX(sale_date) AS last_sale_date,
    DATEDIFF(MONTH, MIN(sale_date), MAX(sale_date)) AS order_range_months
FROM ars.sales;
