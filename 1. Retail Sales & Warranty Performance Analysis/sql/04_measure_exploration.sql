/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the total revenue
SELECT
    SUM(CAST(revenue AS bigint)) AS total_revenue
FROM ars.sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity 
FROM ars.sales

-- Find the average selling price
SELECT AVG(price) AS avg_price 
FROM ars.products

-- Find the total number of sales
SELECT COUNT(sale_id) AS total_orders 
FROM ars.sales

-- Find the total number of claimed warranty
SELECT
    COUNT(claim_id)
FROM ars.warranty

-- Find the total percentage claimed warranty
SELECT
    SUM(sa.quantity) AS total_product_sold,
    COUNT(w.claim_id) AS total_claimed_warranty,
    ROUND(CAST(COUNT(w.claim_id) AS float)/CAST(SUM(sa.quantity) AS float) * 100, 2) AS percentage_of_warranty
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id


-- Generate a Report that shows all key metrics of the business
SELECT 'Total Revenue' AS measure_name, SUM(CAST(revenue AS bigint)) AS measure_value FROM ars.sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM ars.sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM ars.products
UNION ALL
SELECT 'Total Num of Sales', COUNT(sale_id) FROM ars.sales
UNION ALL
SELECT 'Total Num of Products', COUNT(DISTINCT product_name) FROM ars.products
UNION ALL
SELECT 'Total Num of Warranty Issues', COUNT(claim_id) FROM ars.warranty;
