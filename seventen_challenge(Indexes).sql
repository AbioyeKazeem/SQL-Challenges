USE SAMPLEDB

GO

--Index and SARGABLE Query challenges
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.warehouses;

--first challenge
-- Create a non-clustered index on the location_id column in the oes.warehouse table. Also, specify warehouse_name as a non-key included column

CREATE	NONCLUSTERED INDEX ix_warehouses_location_id_inc_warehouse_name
ON oes.warehouses(location_id) INCLUDE (warehouse_name);

-------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.products;

-- second challenge
-- create a unique index on the product_name column in the oes.products table

CREATE UNIQUE INDEX ix_products_product_name
ON oes.products(product_name);
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT order_id, order_date FROM oes.orders;
-- third challenge
-- re-write this using SARGABLE Query
SELECT 
order_id,
order_date
FROM oes.orders
WHERE YEAR(order_date) = 2019;

-- SARGABLE Query
SELECT 
order_id,
order_date
FROM oes.orders
WHERE order_date >='20190101' AND order_date<'20200101';

-------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.orders;
-- fourth challenge
-- most queries against the oes.orders table are for unshipped orders i.e orders where the shipped_date is null. Put an apprpriate filtered index
-- on the shipped_date column
CREATE INDEX ix_orders_shipped_date
ON oes.orders(shipped_date)
WHERE shipped_date IS NULL;

/*
SELECT order_id, shipped_date
FROM oes.orders
WHERE shipped_date IS NULL;
*/

-------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.customers;
-- fifth challenge
-- Rewrite the following to make it sargable and create an index which covers the query, once rewritten
SELECT
customer_id, first_name, last_name, email, street_address
FROM oes.customers
WHERE LEFT(first_name,2) = 'Vi'
AND last_name= 'Jones';

-- solution
SELECT
customer_id, first_name, last_name, email, street_address
FROM oes.customers
WHERE first_name LIKE'Vi%'
AND last_name= 'Jones';

-- index that covers the query above
CREATE NONCLUSTERED INDEX ix_last_first_incl_email_street
ON oes.customers(last_name,first_name)
INCLUDE(email,street_address);

-------------------------------------------------------------------------------------------------------------------------------------------
