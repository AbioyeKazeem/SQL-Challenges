USE SAMPLEDB

GO

---------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.employees;

-- Advanced challenge on JOIN 
-- Challenge1
-- Write a query to return employee details for all employees as well as the first and the last name of each employee's manager. Include
-- employee_id, first_name, last_name, manager_first_name(alias for first_name), manager_last_name(alias for last_name)
-- Hints: Join the employees table onto itself(self join) by joining manager_id to employee_id. Use an OUTER JOIN to include all employees.
-- Give different aliases to each instance of the employees table as specified in the FROM clause. 
-- Note: e2 stand for manager 

SELECT
e.employee_id, e.first_name,e.last_name,e.manager_id, e2.first_name AS manager_first_name, e2.last_name AS manager_last_name
FROM hcm.employees e LEFT OUTER JOIN hcm.employees e2
ON e.manager_id = e2.employee_id;

---------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.products;

SELECT *
FROM oes.warehouses;

SELECT *
FROM oes.inventories;

-- Challenge2
-- Write a query to include all the products at each warehouse include the following attribute
-- product_id, product_name,warehouse_id,warehouse_name and quantity_on_hand
-- Join multiple tables: oes.products, oes.warehouses, oes.inventories. Check the ERD of the SAMPLEDB to see how these tables are related to each other.
-- use INNER JOIN between the 3 tables

SELECT 
p.product_id, p.product_name, w.warehouse_id, w.warehouse_name, quantity_on_hand
FROM oes.products p INNER JOIN oes.inventories i
ON p.product_id = i.product_id
INNER JOIN oes.warehouses w
ON w.warehouse_id = i.warehouse_id;


---------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.employees;

SELECT * 
FROM hcm.departments;

SELECT *
FROM hcm.jobs;

SELECT *
FROM hcm.countries;

SELECT * 
FROM hcm.locations;

-- Challenge3
-- write a query to return the following attributes for all employees from Australia
-- employee_id, first_name, last_name, department_name, job_title, state_province
-- Join multiple tables, hcm.employees, hcm.departments, hcm.jobs, hcm.countries. 
-- Also, include a WHERE clause to keep only employees from Australia.
-- Hint: Outer Join is required employees and department table cos u are to return all employees from Australia irrespective of wheather they av dept or not
SELECT 
e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title, e.state_province
FROM hcm.employees e LEFT OUTER JOIN hcm.departments d
ON e.department_id = d.department_id
INNER JOIN hcm.jobs j
ON e.job_id = j.job_id
INNER JOIN hcm.countries c
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';

-- OR 

SELECT 
e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title, e.state_province
FROM hcm.employees e LEFT OUTER JOIN hcm.departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN hcm.jobs j
ON e.job_id = j.job_id
LEFT OUTER JOIN hcm.countries c
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';

--------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.products;

SELECT *
FROM oes.order_items;

SELECT *
FROM oes.product_categories;

-- Challenge4
-- Return the quantity ordered of each product in each category. Do not include products which have never been ordered. 
-- Include the product name and category name in the query
-- order the result by category name from A to Z and then within each category name order by product name from A to Z
-- Hint: join multiple tables oes.products, oes.order_items, oes.product_categories. Group By product_name and category_name. 
-- Use the Sum aggregate function


SELECT p.product_name, pc.category_name,  SUM(quantity) AS total_quantity_ordered
FROM oes.products p INNER JOIN oes.order_items o
ON  p.product_id = o.product_id
INNER JOIN oes.product_categories pc
ON  pc.category_id = p.category_id 
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name;

------------------------------------------------------------------------------------------------------------------------------------------------

-- Challenge5
-- Return the quantity ordered of each product in each category. Include products which have never been ordered. Include the product name
-- and category name in the query
-- order the result by category name from A to Z and then within each category name order by product name from A to Z
-- Hint: join multiple tables oes.products, oes.order_items, oes.product_categories. 
-- This query requires an OUTER JOIN
-- Group By product_name and category_name. 
-- Use the Sum aggregate function
-- NEST the SUM function within a COALESCE function to replace NULLS with ZEROS

SELECT p.product_name, pc.category_name, SUM(COALESCE(quantity,0)) AS total_quantity_ordered
FROM oes.products p LEFT JOIN oes.order_items o
ON  p.product_id = o.product_id
LEFT JOIN oes.product_categories pc
ON pc.category_id = p.category_id
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name ASC;
-----------------------------------------------------------------------------------------------------------------------------------------------