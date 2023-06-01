USE SAMPLEDB

GO
------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.employees;
-- first challenge on SQL FUNCTION
-- Concatenate the firstname and lastname of each employee, include a single space between the first name and the lastname. Name the new expression
-- as employee_name 
-- employee_id, first_name, last_name and employee_name
--Hint: Use + operator or CONCAT to concatenate first and last name

SELECT
first_name,last_name,
first_name + ' ' + last_name  AS employee_name
FROM hcm.employees;

-- OR 

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS employee_name
FROM hcm.employees;


------------------------------------------------------------------------------------------------------------------------------------------------
-- second challenge
-- Concatenate the firstname, middlename, lastname of each employee, include a single space between each of the names. Name the new expression
-- as employee_name 
-- employee_id, first_name, middle_name, last_name and employee_name and be mindful that the middlename allows null

SELECT 
first_name, middle_name, last_name,
first_name + ISNULL(' ' + middle_name, ' ') + ' ' + last_name AS employee_name
FROM hcm.employees;

-- OR 

SELECT first_name, middle_name, last_name,
CONCAT(first_name,' ' + middle_name, ' ', last_name)
FROM hcm.employees;

-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM bird.antarctic_species;
-- third challenge
-- Extract the genus name from the scientific_name as given in the bird.antarctic_species table
-- Hint: use CHARINDEX function to find the position of the first space. Minus 1 of the position to get the position of the last character
-- for the genus name. NEST this within the LEFT FUNCTION.
SELECT 
species_id, scientific_name, common_name,
LEFT(scientific_name, CHARINDEX(' ', scientific_name) -1)  AS genus_name
FROM bird.antarctic_species;


-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM bird.antarctic_species;

-- fourth challenge
-- Extract the species name from the scientific_name as given in the bird.antarctic_species table
-- Hint: use the CHARINDEX function to find the position of the single space, Add 1 to get the position of the first character of the species name
-- Nest this as the second argument within the SUBSTRING function. Also nest the LEN function within the third argument of the same SUBSTRING Fxn.
SELECT 
species_id, scientific_name, common_name,
SUBSTRING(scientific_name, CHARINDEX(' ', scientific_name) + 1, LEN(scientific_name)) AS species_name
FROM bird.antarctic_species;
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.employees;

-- fifth challenge
-- return the age in years for all employees. Name this expression as employee_age, include employee_id, first_name, last_name, birth_date, employee_age
-- Hint: Use the DATEDIFF function. An employee's age will be the difference between birth_date and current system datetime which you can get
-- by referencing either the GETDATE() function or the CURRENT_TIMESTAMP function.

SELECT 
employee_id, first_name, last_name, birth_date,
DATEDIFF(year,birth_date,CURRENT_TIMESTAMP ) AS "employee's age"
FROM
hcm.employees;

-- OR

SELECT 
employee_id, first_name, last_name, birth_date,
DATEDIFF(year,birth_date,GETDATE()) AS "employee's age"
FROM
hcm.employees;

-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.orders;

-- sixth challenge
-- Assuming an estimated shipping date of 7 days after the order date, add a column expression called estimated_shipping_date for all unshipped orders
-- include order_id, order_date, estimated_shipping_date
-- Hint: unshipped orders are ones where the shipped date is NULL. Use DATEADD function to add 7 days to the order_date.

SELECT
order_id, order_date,
DATEADD(day, 7, order_date) AS estimated_shipping_date
FROM oes.orders
WHERE shipped_date IS NULL;

------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.orders;

SELECT * 
FROM oes.shippers;

-- Calculate the average number of days it takes each shipping company to ship an order. Call this expression avg_shipping_days, include
-- company_name, avg_shipping_days
--Hint: Join the oes.orders table to the oes.shippers table in order to get the company name. Group by company name. In the select clause.
-- use the DATEDIFF function to calculate the difference in days between order date and shipped date. Nest the result within the AVG aggregate 
-- function to get the average for each shipping company.

SELECT company_name, AVG(DATEDIFF(day,order_date,shipped_date)) AS avg_shipping_days
FROM oes.orders ord JOIN oes.shippers sh
ON ord.shipper_id = sh.shipper_id
GROUP BY sh.company_name;
-------------------------------------------------------------------------------------------------------------------------------------------------