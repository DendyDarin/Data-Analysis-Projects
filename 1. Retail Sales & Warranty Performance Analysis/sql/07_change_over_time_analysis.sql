/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
SELECT
    YEAR(sale_date) AS order_year,
    MONTH(sale_date) AS order_month,
    SUM(revenue) AS total_sales,
    SUM(quantity) AS total_quantity
FROM ars.sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), MONTH(sale_date);

-- DATETRUNC()
SELECT
    DATETRUNC(month, sale_date) AS order_date,
    SUM(revenue) AS total_sales,
    SUM(quantity) AS total_quantity
FROM ars.sales
GROUP BY DATETRUNC(month, sale_date)
ORDER BY DATETRUNC(month, sale_date);

-- FORMAT()
SELECT
    FORMAT(sale_date, 'yyyy-MMM') AS order_date,
    SUM(revenue) AS total_sales,
    SUM(quantity) AS total_quantity
FROM ars.sales
GROUP BY FORMAT(sale_date, 'yyyy-MMM')
ORDER BY FORMAT(sale_date, 'yyyy-MMM');
