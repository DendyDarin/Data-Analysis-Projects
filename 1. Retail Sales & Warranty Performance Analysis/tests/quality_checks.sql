/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the table. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after extracting data.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'ars.category'
-- ====================================================================
-- Check for NULLs
SELECT
*
FROM ars.category
WHERE category_id IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    category_id,
    COUNT(*)
FROM ars.category
GROUP BY category_id
HAVING COUNT(*) > 1
-- Result: no duplicate found

-- ====================================================================
-- Column category_name
-- Check for NULLs
SELECT *
FROM ars.category
WHERE category_name IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    category_name,
    COUNT(*)
FROM ars.category
GROUP BY category_name
HAVING COUNT(*) > 1
-- Result: no duplicate found

-- Check for unwanted spaces
SELECT category_name
FROM ars.category
WHERE category_name != TRIM(category_name)
-- Result: no unwanted spaces found

-- ====================================================================
-- Checking 'ars.products'
-- ====================================================================
-- Check for NUlls
SELECT *
FROM ars.products
WHERE product_id IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    product_id,
    COUNT(*)
FROM ars.products
GROUP BY product_id
HAVING COUNT(*) > 1
-- Result: no duplicate found

-- ====================================================================
-- Column product_name
-- Check for NUlls
SELECT *
FROM ars.products
WHERE product_name IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    product_name,
    COUNT(*)
FROM ars.products
GROUP BY product_name
HAVING COUNT(*) > 1
-- Result: duplicate found (HomePod mini)

-- Update product_name to differentiate (in this case give number 1 and 2)
SELECT *
FROM ars.products
WHERE product_name = 'HomePod mini'

UPDATE ars.products
SET product_name = 'HomePod mini 1'
WHERE product_id = 'P-21'

UPDATE ars.products
SET product_name = 'HomePod mini 2'
WHERE product_id = 'P-75'

-- Update product_name Apple Watch Hermes for clarity
UPDATE ars.products
SET product_name = 'Apple Watch Hermes'
WHERE product_id = 'P-49'

-- Check for unwanted spaces
SELECT *
FROM ars.products
WHERE product_name != TRIM(product_name)
-- Result: no unwanted spaces found

-- ====================================================================
-- Column launch_date
-- Change datatype string to date in launch_date column
ALTER TABLE ars.products
ALTER COLUMN launch_date DATE;

-- ====================================================================
-- Column price
-- Check for NULLs, zero, and negative values
SELECT price
FROM ars.products
WHERE price IS NULL OR price <= 0
-- No issues

-- ====================================================================
-- Checking 'ars.stores'
-- ====================================================================
-- Check for NUlls
SELECT *
FROM ars.stores
WHERE store_id IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    store_id,
    COUNT(*)
FROM ars.stores
GROUP BY store_id
HAVING COUNT(*) > 1
-- Result: no duplicate found

-- ====================================================================
-- Column store_name
-- Check for unwanted spaces
SELECT *
FROM ars.stores
WHERE store_name != TRIM(store_name)
-- Result: no unwanted spaces found

-- ====================================================================
-- Column city
-- Check for unwanted spaces
SELECT *
FROM ars.stores
WHERE city != TRIM(city)
-- Result: no unwanted spaces found

-- ====================================================================
-- Column country
-- Check for unwanted spaces
SELECT *
FROM ars.stores
WHERE country != TRIM(country)
-- Result: no unwanted spaces found

-- ====================================================================
-- Checking 'ars.warranty'
-- ====================================================================
-- Check for NUlls
SELECT *
FROM ars.warranty
WHERE claim_id IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    claim_id,
    COUNT(*)
FROM ars.warranty
GROUP BY claim_id
HAVING COUNT(*) > 1

-- ====================================================================
-- Column claim_date
-- Change datatype string to date
ALTER TABLE ars.warranty
ALTER COLUMN claim_date DATE;

-- ====================================================================
-- Column repair_status
SELECT DISTINCT repair_status
FROM ars.warranty
-- No issues

-- ====================================================================
-- Checking 'ars.sales'
-- ====================================================================
-- Check for NUlls
SELECT *
FROM ars.sales
WHERE sale_id IS NULL
-- Result: no NULL found

-- Check for duplicates
SELECT 
    sale_id,
    COUNT(*)
FROM ars.sales
GROUP BY sale_id
HAVING COUNT(*) > 1
-- Result: no duplicate found

-- ====================================================================
-- Column sale_date
-- Change string format and datatype
-- Step 1. Change string format
SELECT 
    sale_id,
    sale_date,
    CONCAT(SUBSTRING(sale_date, 7, 4) ,'-' ,SUBSTRING(sale_date, 4, 2), '-', SUBSTRING(sale_date, 1, 2)) AS new_sale_date
FROM ars.sales

UPDATE ars.sales
SET sale_date = CONCAT(SUBSTRING(sale_date, 7, 4) ,'-' ,SUBSTRING(sale_date, 4, 2), '-', SUBSTRING(sale_date, 1, 2))

-- Step 2. Change datatype string to date
ALTER TABLE ars.sales
ALTER COLUMN sale_date DATE;

-- Add new column revenue
-- Revenue is calculated as quantity * product price.
-- This ensures historical accuracy and improves BI query performance.

-- Step 1. Adding new column
ALTER TABLE ars.sales
ADD revenue int;

-- Step 2. Populate revenue using UPDATE with JOIN
UPDATE sa
SET sa.revenue = sa.quantity * p.price
FROM ars.sales sa
JOIN ars.products p
    ON sa.product_id = p.product_id

-- ====================================================================
-- Column store_id
-- Check relationship with store_id in ars.stores table
SELECT *
FROM ars.sales
WHERE store_id NOT IN (SELECT store_id FROM ars.stores)
-- No issues

-- ====================================================================
-- Column product_id
-- Check relationship with product_id in ars.products table
SELECT product_id
FROM ars.sales
WHERE product_id NOT IN (SELECT product_id FROM ars.products)
-- No issues

-- ====================================================================
-- Column quantity
-- Check for NULLs, zero, and negative values
SELECT quantity
FROM ars.sales
WHERE quantity IS NULL OR quantity <= 0
-- No issues
