USE SAMPLEDB
GO

SELECT *
FROM hcm.employees;

--------------------------------------------------------------------------------------------------------------------------
-- Challenge1
-- Write a query that give total number of employees in each department as given by the department_id column in the hcm.employees table
--Hint: use the COUNT aggregate function in the SELECT clause, also use a GROUP BY clause.Note, all the challenges in this lecture require GROUP BY.

SELECT 
department_id,
Count(*) AS total_employee
FROM hcm.employees
GROUP BY department_id;

--OR 

SELECT 
department_id,
Count(*) AS total_employee
FROM hcm.employees
GROUP BY department_id;

--OR

SELECT 
department_id,
Count(*) AS total_employee
FROM hcm.employees
WHERE department_id IS NOT NULL
GROUP BY department_id;
-----------------------------------------------------------------------------------------------------------------------------

-- Challenge2
-- Write a query to give the average salary in each department as given by department_id column in the hcm.employees table. Order the query result
-- by average salary from highest to lowest
-- Hint: include the AVG aggregate function in the SELECT function.

SELECT 
department_id,
-- ROUND FUNCTION  is used 
ROUND(AVG(salary), 1) AS avg_salary
FROM hcm.employees
WHERE department_id IS NOT NULL 
GROUP BY department_id
ORDER BY avg_salary DESC;

-- OR

SELECT
department_id,
AVG(salary) AS avg_salary
FROM hcm.employees
GROUP BY department_id
ORDER BY avg_salary DESC;

------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.inventories;
-- Challenge3
-- Write a query to give the total number of products on hand at each warehouse as given by the warehouse_id column in the oes.inventories table
-- Also limit the result to only warehouses which have greater than 5,000 product items on hand
-- Hint: Use the SUM aggregate function in the SELECT clause, include a HAVING clause in the query, The HAVING clause will also have the SUM aggregate
-- function

SELECT 
warehouse_id,
Sum(quantity_on_hand) AS total_product_on_hand
FROM oes.inventories
GROUP BY warehouse_id
HAVING SUM (quantity_on_hand) > 5000;

---------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM bird.antarctic_populations;
-- Challenge4
-- What is the date of the most recent population count at each locality in the bird.antarctic_populations table
--Hint: use the MAX aggregate function in the SELECT clause

SELECT 
locality,
MAX(date_of_count) AS Most_recent_pop_date
FROM bird.antarctic_populations
Group BY locality;
----------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM bird.antarctic_populations;
-- Challenge5
-- what is the date of the most recent population count for each species at each locality in the bird.antarctic_populations table?
-- Hint: Group by more than one column.
SELECT locality,
species_id,
MAX(date_of_count) AS Most_recent_species_date
FROM bird.antarctic_populations
GROUP BY locality, species_id;


