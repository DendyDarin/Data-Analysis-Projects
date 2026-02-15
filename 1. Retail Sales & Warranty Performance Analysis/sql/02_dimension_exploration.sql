/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique store's name from sales
SELECT DISTINCT 
    st.store_name 
FROM ars.sales sa
LEFT JOIN ars.stores st
    ON sa.store_id = st.store_id
ORDER BY st.store_name;

-- Retrieve a list of unique products and categories
SELECT DISTINCT  
    p.product_name,
    c.category_name
FROM ars.sales sa
LEFT JOIN ars.products p
    ON sa.product_id = p.product_id
LEFT JOIN ars.category c
    ON p.category_id = c.category_id
ORDER BY p.product_name, c.category_name;
