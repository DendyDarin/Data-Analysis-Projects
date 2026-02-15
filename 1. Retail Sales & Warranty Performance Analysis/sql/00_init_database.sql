/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'AppleRetailSales' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called ars
	
WARNING:
    Running this script will drop the entire 'AppleRetailSales' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'AppleRetailSales' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'AppleRetailSales')
BEGIN
    ALTER DATABASE AppleRetailSales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AppleRetailSales;
END;
GO

-- Create the 'AppleRetailSales' database
CREATE DATABASE AppleRetailSales;
GO

USE AppleRetailSales;
GO

-- Create Schemas

CREATE SCHEMA ars;
GO

CREATE TABLE ars.category(
	category_id nvarchar(50),
	category_name nvarchar(50)
);
GO

CREATE TABLE ars.products(
	product_id nvarchar(50),
	product_name nvarchar(50),
	category_id nvarchar(50),
	launch_date nvarchar(50),
	price int
);
GO

CREATE TABLE ars.sales(
	sale_id nvarchar(50),
	sale_date nvarchar(50),
	store_id nvarchar(50),
	product_id nvarchar(50),
	quantity int
);
GO

CREATE TABLE ars.stores(
	store_id nvarchar(50),
	store_name nvarchar(50),
	city nvarchar(50),
	country nvarchar(50)
);
GO

CREATE TABLE ars.warranty(
	claim_id nvarchar(50),
	claim_date nvarchar(50),
	sale_id nvarchar(50),
	repair_status nvarchar(50)
);
GO

TRUNCATE TABLE ars.category;
GO

BULK INSERT ars.category
FROM 'E:\3 LEARN\DATA BANKS\apple_retail\category.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE ars.products;
GO

BULK INSERT ars.products
FROM 'E:\3 LEARN\DATA BANKS\apple_retail\products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE ars.sales;
GO

BULK INSERT ars.sales
FROM 'E:\3 LEARN\DATA BANKS\apple_retail\sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE ars.stores;
GO

BULK INSERT ars.stores
FROM 'E:\3 LEARN\DATA BANKS\apple_retail\stores.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE ars.warranty;
GO

BULK INSERT ars.warranty
FROM 'E:\3 LEARN\DATA BANKS\apple_retail\warranty.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
