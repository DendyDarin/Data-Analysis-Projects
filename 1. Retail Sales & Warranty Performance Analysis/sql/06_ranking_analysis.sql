/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
    p.product_name,
    SUM(sa.revenue) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(sa.revenue) AS total_revenue,
        RANK() OVER (ORDER BY SUM(sa.revenue) DESC) AS rank_products
    FROM ars.sales sa
    LEFT JOIN ars.products p
        ON sa.product_id = p.product_id
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    p.product_name,
    SUM(sa.revenue) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue;

-- The 5 products with the highest orders placed
SELECT TOP 5
    p.product_name,
    SUM(sa.quantity) AS total_orders
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- The 5 products with the lowest orders placed
SELECT TOP 5
    p.product_name,
    SUM(sa.quantity) AS total_orders
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders;

-- The top 5 most popular smartphone
SELECT TOP 5
    p.product_name,
    SUM(sa.quantity) AS total_orders
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Smartphone'
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- The top 5 most popular watch
SELECT TOP 5
    p.product_name,
    SUM(sa.quantity) AS total_orders
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
WHERE p.product_name LIKE '%Watch%'
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- The top 5 most popular MacBook
SELECT TOP 5
    p.product_name,
    SUM(sa.quantity) AS total_orders
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
WHERE p.product_name LIKE '%MacBook%'
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- Find top 5 most warranty issues by each product
SELECT TOP 5
    p.product_name,
    COUNT(w.claim_id) AS total_warranty_issue
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_warranty_issue DESC

-- Find top 5 most rejected warranty by each product
SELECT TOP 5
    p.product_name,
    COUNT(w.claim_id) AS total_rejected_warranty
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
WHERE w.repair_status = 'Rejected'
GROUP BY p.product_name
ORDER BY total_rejected_warranty DESC
