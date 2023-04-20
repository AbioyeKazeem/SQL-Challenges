USE SAMPLEDB
GO


SELECT * FROM hcm.employees;

-- QUERRY USING ORDER BY, FILTERING BY (TOP) AND TOP WITH TIES USAGE IN SQL

-- All employees ordered alphabetically by their lastname in Ascending order
SELECT * FROM hcm.employees
ORDER BY last_name ASC;


-- OR use this
SELECT * FROM hcm.employees
ORDER BY last_name;


-- All employees order by salary from highest to lower
SELECT * FROM hcm.employees
ORDER BY salary DESC;


-- All employees ordered by most recently hired to longest serving
SELECT * FROM hcm.employees
ORDER BY hire_date DESC;


-- All employees order by department_id in Ascending order and within each dept, order by salary from highest to lowest
SELECT * FROM hcm.employees
ORDER BY department_id ASC, salary DESC;


--OR
SELECT * FROM hcm.employees
ORDER BY department_id, salary DESC;


-- Return employee_id, first name, last name and salary for the top 10 employees who get paid most
SELECT top(10) employee_id, first_name, last_name,salary
FROM hcm.employees
ORDER BY salary DESC;

-- Querry to return employee_id, first_name, last_name and salary for the employee/employees who get paid the least
SELECT Top(1) WITH TIES employee_id, first_name, last_name, salary
FROM hcm.employees
ORDER BY salary ASC;


