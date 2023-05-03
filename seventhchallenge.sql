USE SAMPLEDB

GO

SELECT * 
FROM 
hcm.employees;
-----------------------------------------------------------------------------------------------------------------------------------------------
--Challenge1 
-- select employees from hcm.employee who live in either seattle or sydney
-- Hint: use OR operator

SELECT *
FROM
hcm.employees
WHERE city='Seattle' OR city='Sydney';

------------------------------------------------------------------------------------------------------------------------------------------------

-- Challenge2
--select employees who live in any of the following cities  
--seattle
--sydney
--ascot
--hillston
-- Hint: Use IN operator

SELECT *
FROM hcm.employees
WHERE city IN ('Seattle', 'Sydney','Ascot', 'Hillston');
------------------------------------------------------------------------------------------------------------------------------------------------

-- Challenge3
-- Select employees from sydney whose salary greater than $200,000
-- Hint: use AND operator

SELECT *
FROM hcm.employees
WHERE city='Sydney' AND salary > 200000;

------------------------------------------------------------------------------------------------------------------------------------------------

-- Challenge4
-- Select employees who live either in seattle or sydney and were also hired on or after 1st january 2019.
--Hint: use both OR and AND logical operator (Precedence is required here)

SELECT *
FROM
hcm.employees
WHERE (city='Seattle' OR city='Sydney') AND hire_date >= '20190101';



-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM oes.products

--Challenge5
-- select products from oes.products table which do not have a product category_id of either 1,2 or 5
SELECT *
FROM 
oes.products
WHERE category_id NOT IN (1,2,5);
-------------------------------------------------------------------------------------------------------------------------------------------------