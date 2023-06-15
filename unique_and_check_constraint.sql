USE SAMPLEDB

GO

-- query information schema views to get metadata on constraints on hcm.departments table
-- use this syntax to check the constraint on a given table 
SELECT 
tc.TABLE_SCHEMA,
tc.TABLE_NAME,
tc.CONSTRAINT_TYPE,
ccu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
and tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'departments';

-- UNIQUE CONSTRAINT USAGE
--------------------------------------------------------------------------------------------------------------------------------------------
-- challenge
-- use ALTER table to add a UNIQUE CONSTRAINT to the department_name column in the hcm.departments table.

select *
from hcm.departments;



-- check that department_name has only unique values
SELECT COUNT(*) AS total_count, COUNT(DISTINCT department_name) AS unique_value_count
FROM hcm.departments;

-- Adding a UNIQUE constraint to a table
ALTER TABLE hcm.departments
ADD CONSTRAINT uk_departments_department_name UNIQUE (department_name);


-- Attempting to insert duplicate value into department table to test out the UNIQUE CONSTRAINT usage in a table
/*
INSERT INTO hcm.departments(department_name,location_id)
VALUES('administration', 1880);
*/
-- it will give you error cos of the newly added UNIQUE CONSTRAINT added to the table

--------------------------------------------------------------------------------------------------------------------------------------------



-- CHECK CONSTRAINT
-------------------------------------------------------------------------------------------------------------------------------------
SELECT 
tc.TABLE_SCHEMA,
tc.TABLE_NAME,
tc.CONSTRAINT_TYPE,
ccu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
and tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'employees';


-- challenge
-- use ALTER table statement to add a CHECK CONSTRAINT on the salary column in the hcm.employees to ensure that the salary is greater than or equal to zero
ALTER TABLE hcm.employees
ADD CONSTRAINT chk_hcm_employees_salary CHECK (salary >= 0);

SELECT * FROM
hcm.employees;



-------------------------------------------------------------------------------------------------------------------------------------