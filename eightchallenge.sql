USE SAMPLEDB

GO

SELECT *
FROM hcm.departments;


-- This query the total number of row on department_id column
SELECT Count(*) AS row_count,
Count(DISTINCT department_id) AS distinct_row_count
FROM hcm.departments;

-- Query information schema views to get metadata on contraints on hcm.departments table
SELECT
tc.TABLE_SCHEMA,
tc.TABLE_NAME,
tc.CONSTRAINT_TYPE,
ccu.COLUMN_NAME
FROM 
INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
AND tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE TC.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME ='departments';

---------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.departments

SELECT * 
FROM hcm.employees;

-- Challenge1
-- Write a querry  to return the following attrributes for employees who belong to a department
-- employee_id
-- first_name
-- last_name
-- salary
-- department_name
-- Hint: Get department name from hcm.departments table. Get all other attributes from hcm.employees table. Use Inner Join btw the two tables
-- This is cos u are to only include employees who only belong to a department.
SELECT
e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM hcm.employees e INNER JOIN hcm.departments d
ON  d.department_id = e.department_id;

-------------------------------------------------------------------------------------------------------------------------
-- Challenge2
-- Write a querry  to return the following attrributes for all employees, including employees who do not belong to a department
-- employee_id
-- first_name
-- last_name
-- salary
-- department_name
-- Hint: Get department name from hcm.departments table. Get all other attributes from hcm.employees table. Use Outer Join btw the two tables
-- This is cos u are to only include all employees including the ones who does not belong to any department.
-- NOTE: I used LEFT OUTER JOIN OR RIGHT OUTER JOIN here cos am to returns all the required attributes of all employees with department or without department
SELECT
 e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM hcm.employees e LEFT OUTER JOIN hcm.departments d
ON  d.department_id = e.department_id;

-- OR

SELECT
 e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM hcm.departments d RIGHT OUTER JOIN hcm.employees e
ON  d.department_id = e.department_id;

--------------------------------------------------------------------------------------------------------------------------
-- Challenge3
-- Write a query to return the total number of employees in each department, include the department_name in the query result.
-- also include employees who have not been assigned to a department.
-- Hint: Use an outer join as well as GROUP BY clause
SELECT 
d.department_name, Count(*) AS employee_count
FROM hcm.employees e LEFT OUTER JOIN hcm.departments d 
ON d.department_id = e.department_id
GROUP BY d.department_name;

---------------------------------------------------------------------------------------------------------------------------