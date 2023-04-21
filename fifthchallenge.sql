USE SAMPLEDB
GO


-- query the information_schema.columns view to find the collation used
-- for the hcm.countries table
SELECT 
table_schema, table_name, column_name, data_type, collation_name
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'hcm' AND TABLE_NAME = 'countries';


-- Challenge1
SELECT * 
FROM hcm.countries
--Select countries from the hcm.countries which starts with the letter 'N'
--Hint: use LIKE operator and % wildcard
SELECT * 
FROM hcm.countries
WHERE country_name LIKE 'N%'

-- OR
SELECT * 
FROM hcm.countries
WHERE country_name LIKE 'n%';


-- Challenge2
SELECT * 
FROM oes.customers;
-- Select customer from oes.customers table that have a GMAIL email address
SELECT
customer_id,first_name,last_name, email
FROM oes.customers
WHERE email LIKE '%@gmail.com'


-- Challenge3
SELECT *
FROM oes.products;
-- Select product names from oes.products table which contain the word 'mouse' anywhere within the product name
SELECT product_name
FROM oes.products
WHERE product_name LIKE '%mouse%';


--Challenge4
-- Select a product names from the oes.products table which end in a number
SELECT product_name
FROM oes.products
WHERE product_name LIKE '%[0-9]';