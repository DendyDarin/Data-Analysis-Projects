/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Find the total revenue by each product
SELECT
    p.product_name,
    SUM(CAST(sa.revenue AS bigint)) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY p.product_name

-- Find the total revenue by each product category
SELECT
    c.category_name,
    SUM(CAST(sa.revenue AS bigint)) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY c.category_name

--Find the total revenue by each store
SELECT
    st.store_name,
    SUM(CAST(sa.revenue AS bigint)) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.store_name
ORDER BY st.store_name

-- Find the total revenue by each country
SELECT
    st.country,
    SUM(CAST(sa.revenue AS bigint)) AS total_revenue
FROM ars.sales sa
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.country
ORDER BY st.country

-- Find the total number of sales by each product
SELECT
    p.product_name,
    SUM(sa.quantity) AS total_products_sold
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY p.product_name

-- Find the total number of sales by product category
SELECT
    c.category_name,
    SUM(sa.quantity) AS total_num_of_sales
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY c.category_name

-- Find the total number of sales by each stores
SELECT
    st.store_name,
    SUM(sa.quantity) AS total_num_of_sales
FROM ars.sales sa
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.store_name
ORDER BY st.store_name

-- Find the total number of sales by each country
SELECT
    st.country,
    SUM(sa.quantity) AS total_num_of_sales
FROM ars.sales sa
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.country
ORDER BY st.country

-- Find the total number of warranty issued by each product
SELECT
    p.product_name,
    COUNT(w.claim_id) AS total_warranty_issue
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_warranty_issue DESC

-- Find the total number of warranty issued by each category
SELECT
    c.category_name,
    COUNT(w.claim_id) AS total_warranty_issue
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_warranty_issue DESC

-- Find the total number of warranty issued by each store
SELECT
    st.store_name,
    COUNT(w.claim_id) AS total_warranty_issue
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.store_name
ORDER BY total_warranty_issue DESC

-- Find the total number of warranty issued by each country
SELECT
    st.country,
    COUNT(w.claim_id) AS total_warranty_issue
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
GROUP BY st.country
ORDER BY total_warranty_issue DESC

-- Find the total percentage warranty issue by each product
SELECT
    p.product_name,
    ROUND(CAST(COUNT(w.claim_id) AS float)/CAST(SUM(sa.quantity) AS float) * 100, 2) AS percentage_of_warranty
FROM ars.sales sa
LEFT JOIN ars.warranty w
    ON sa.sale_id = w.sale_id
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
GROUP BY p.product_name
ORDER BY percentage_of_warranty DESC;

