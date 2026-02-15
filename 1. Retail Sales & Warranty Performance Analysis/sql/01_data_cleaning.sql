-- ==================================================================
-- Data Cleaning Process
-- ==================================================================
-- sales Table
-- ------------------------------------------------------------------

-- Check NULL values
SELECT
sale_id,
sale_date,
store_id,
product_id,
quantity
FROM sales
WHERE sale_id IS NULL
OR sale_date IS NULL
OR store_id IS NULL
OR product_id IS NULL
OR quantity IS NULL;
-- Results: no NULL values found

-- Change sale_date column datatype to DATE
ALTER TABLE sales
ALTER COLUMN sale_date DATE;

-- Check relation between store_id column and Store_ID from stores table 
SELECT sale_id, store_id
FROM sales
WHERE store_id NOT IN (SELECT Store_ID FROM stores)  
-- Results: Ok, all store_id are in sales

-- Check relation between product_id column and Product_ID from products table
SELECT sale_id, product_id
FROM sales
WHERE product_id NOT IN
	(SELECT Product_ID FROM products) 
-- Results: Ok, all product_id are in sales

-- ==================================================================
-- category Table
-- ------------------------------------------------------------------
-- Check relation between category_id column and Category_ID in products table
SELECT *
FROM category
WHERE category_id NOT IN
	(SELECT Category_ID FROM products) 
-- Results: Ok, all category_id are in products

-- ==================================================================
-- product Table
-- ------------------------------------------------------------------
-- Check Product_Name for any unwanted spaces
SELECT
Product_ID,
Product_Name
FROM products
WHERE Product_Name != TRIM(Product_Name) 
-- Results: Ok, no unwanted spaces found

-- Check relation between Product_ID and product_id in sales table
SELECT
Product_ID,
Product_Name
FROM products
WHERE Product_ID NOT IN
	(SELECT product_id FROM sales) 
-- Results: Ok, all product are in sales table

-- Check relation between Category_ID and category_id in category table
SELECT
Product_ID,
Product_Name,
Category_ID
FROM products
WHERE Category_ID NOT IN
	(SELECT category_id FROM category) 
-- Results: Ok, all category are in category table

-- ==================================================================
-- store Table
-- ------------------------------------------------------------------
SELECT *
FROM stores
-- Results: Ok

-- ==================================================================
-- warranty Table
-- ------------------------------------------------------------------
SELECT *
FROM warranty
-- Results: Ok
