USE SAMPLEDB

GO

------------------------------------------------------------------------------------------------------------------------------------------------
SELECT product_id,product_name, list_price, category_id
FROM  oes.products;
-- Challenge1
-- Return the following product details for the cheapest product(s) in the oes.products table:
-- product_id, product_name, list_price, category_id:
-- Hint: use the MIN aggregate function in a self-contained subquery in the WHERE clause.

SELECT
product_id, product_name, list_price, category_id
FROM oes.products WHERE list_price = (SELECT MIN(list_price) FROM oes.products);

-- OR

SELECT 
TOP(1) WITH TIES
product_id, product_name, list_price, category_id
FROM oes.products
ORDER BY list_price ASC;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge2 
-- Use a correlated subquery to return the following product details for the cheapest product(s) in the oes.products table
-- product_id, product_name, list_price, category_id as Given by the category_id column:
--Hint:Put the subquery in the WHERE clause. The subquery will also have a WHERE clause which references category_id in the outer query
-- hence making it a correlated subquery.

SELECT p1.product_id, p1.product_name, p1.list_price, p1.category_id
FROM oes.products p1
WHERE p1.list_price = (SELECT MIN(p2.list_price) FROM oes.products p2 where p2.category_id = p1.category_id);

---------------------------------------------------------------------------------------------------------- --------------------------------------
-- Challenge3
-- Return the same result as challenge2 i.e the cheapest products in each product category except this time by using INNER JOIN to a derived table
-- calculate the minimum price for each category_id group. Put this in an aliased subquery in the FROM CLAUSE. Then JOIN this (derived table) to the 
-- products table joining both category_id and on price

SELECT p1.product_id, p1.product_name,p1.list_price,p1.category_id
FROM oes.products p1 
INNER JOIN 
( SELECT 
 category_id, Min(list_price) AS min_list_price FROM oes.products
 GROUP BY category_id
 )p2
 ON p2.category_id = p1.category_id
 AND p1.list_price = p2.min_list_price;


------------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge4
-- return the same result as challenge 2 and 3 i.e the cheapest product(s) in each product category except that you will use Common table expression(CTE).
-- Hint:Calculate the minimum price for each category_id group. Put this in a common table expression.In the outer query, join the common table expression
-- to the products table joining on both category_id and on price.

WITH cp AS
( SELECT 
 category_id, Min(list_price) AS min_list_price FROM oes.products
 GROUP BY category_id
 )
 SELECT p.product_id, p.product_name,p.list_price,p.category_id
FROM oes.products p
INNER JOIN cp p2
ON p2.category_id = p.category_id
AND p.list_price = p2.min_list_price;

--OR

WITH cp AS 
(
SELECT product_id, product_name,list_price,category_id,
Min(list_price) OVER (PARTITION BY category_id ORDER BY list_price) AS Min_price
FROM oes.products)
SELECT cp.product_id, cp.product_name,cp.list_price,cp.category_id
FROM cp
WHERE cp.Min_price = list_price;

-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.product_categories;
-- Challenge5
-- Repeat challenge4, except this time include the product category name as given in  oes.product_categories table
--Hint: In the outer query, include an additional join to the oes.product_categories table in order to get the category name.

WITH cp AS (
SELECT category_id, Min(list_price) AS min_list_price
FROM oes.products
 GROUP BY category_id
 )
SELECT p.product_id, p.product_name,p.list_price,p.category_id
FROM oes.products p
INNER JOIN oes.product_categories pc
ON pc.category_id = p.category_id
INNER JOIN cp p2
ON p.category_id = p2.category_id
AND
p.list_price = p2.min_list_price;


-- OR 

WITH cp AS 
(
SELECT product_id, product_name,list_price,category_id,
Min(list_price) OVER (PARTITION BY category_id ORDER BY list_price) AS Min_price
FROM oes.products)
SELECT cp.product_id, cp.product_name,cp.list_price,cp.category_id,pc.category_name
FROM cp
LEFT OUTER JOIN oes.product_categories pc
ON cp.category_id = pc.category_id
WHERE cp.Min_price = list_price;
----------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.orders;

SELECT * 
FROM hcm.employees;
--Challenge6
--Background: The employee_id column in the oes.orders table gives employee_id of the salesperson who made the sale.
-- Use the NOT IN operator to return all employeess who have never been the salesperson for any customer order. Include the following columns
-- from hcm.emplyees
-- employee_id, first_name, last_name
-- Hint: Use the NOT IN operator in conjuction with a self-contianed subquery. However, make sure to exclude nulls from employee_id column 
-- in the oes.orders table as referenced in the subquery.

SELECT employee_id, first_name, last_name
FROM hcm.employees 
WHERE employee_id NOT IN ( SELECT employee_id FROM oes.orders WHERE employee_id IS NOT NULL);
---------------------------------------------------------------------------------------------------------------------------------------------
--Challenge7
-- return the same result as challenge6, EXCEPT use WHERE NOT EXISTS
-- Hints: use a correlated subquery to correlate the employee_id in the oes.orders table to the employee_id in the hcm.employees table.
SELECT e.employee_id, e.first_name, e.last_name
FROM hcm.employees e 
WHERE NOT EXISTS ( SELECT employee_id FROM oes.orders o WHERE o.employee_id = e.employee_id  );
---------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.customers;

SELECT * 
FROM oes.orders;

SELECT * 
FROM oes.order_items;

SELECT * 
FROM oes.products;


--Challenge8
-- return the unique customers who have ordered the PBX smart watchh 4. Include customer_id, firstname,lastname,email
--Hint: Use IN operator in conjuction with a self-contained subquery, select customer id's in the subquery for customers who ordered the
-- PBX smartwatch 4. Also in the subquery, you need to join oes.orders table to the oes.order_items and join this to oes.products
-- filter oes.products to return rows where the product name equals PBX Smart Watch 4.
SELECT c.customer_id, c.first_name,c.last_name,c.email
FROM oes.customers c
WHERE c.customer_id IN ( SELECT o.customer_id FROM oes.orders o 
 JOIN  oes.order_items ot
ON o.order_id = ot.order_id 
 JOIN oes.products p
ON p.product_id = ot.product_id
WHERE p.product_name = 'PBX Smart Watch 4');