USE SAMPLEDB

GO


--------------------------------------------------------------------------------------------------------------------------------------------------------
--Create/Insert into table challenges
-- first challenge
-- Create a table called depts in the dbo schema. specify the following columns
-- dept_id IN, dept_name VARCHAR(50)
-- Give the identity column to the dept_id column. Also put a primary key constraint on dept_id column. Put a NOT NULL constraint on dept_name column
-- Hints: A NOT NULL is defined 'in-line' after the data type. Whereas, typically, a primary key constraint is defined after the last column's data type.
CREATE Table dbo.deptx (
                        dept_id INT IDENTITY(1,1),
						dept_name VARCHAR(50) NOT NULL,
						CONSTRAINT pk_dept_id PRIMARY KEY (dept_id)
				       );


--OR

/*
CREATE TABLE dept (
            dept_id INT IDENTITY(1,1) PRIMARY KEY,
			dept_name VARCHAR(50) NOT NULL,
                 );
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM dbo.deptx;
-- second challenge
-- write into the dbo.depts table Business Intelligence as depst_name

INSERT INTO dbo.deptx (dept_name)
        VALUES('Business Intelligence');
-------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM hcm.departments;

SELECT * 
FROM deptx;

-- third challenge 
-- populate dbo.deptx table with more rows, insert all departnames from hcm.departments table.
-- Use a SELECT...INSERT INTO statement to select department names from hcm.departments table and insert them into dbo.depts table
-- note you only need to insert department name into the column in the select statement.
INSERT INTO dbo.deptx (dept_name)
SELECT department_name
FROM hcm.departments;

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- fourth challenge
-- create a table called emp in the dbo schema. Specify the following columns 
-- emp_id INT, first_name VARCHAR(50), last_name VARCHAR(50), hire_date DATE, dept_id INT
-- Give the identity property to the emp_id, also put a primary key constraint on the emp_id column. Put NON NULL constraints on any columns you think need them
-- put a foreign key constraint on the dept_id column from dbo.depts table
-- Hints: Syntax for Foreign key: fk_name FOREIGN KEY (CHILD_COL) REFERENCES parent_table (parent_col)
CREATE TABLE dbo.emp (
                      emp_id INT IDENTITY(1,1),
					  first_name VARCHAR(50) NOT NULL,
					  last_name VARCHAR(50) NOT NULL,
					  hire_date DATE NOT NULL,
					  dept_id INT NOT NULL,
					  CONSTRAINT pk_emp_id PRIMARY KEY (emp_id),
					  CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES deptx (dept_id)
                      );

SELECT * 
FROM dbo.emp;
-------------------------------------------------------------------------------------------------------------------------------------------------------
--fifth challenge
-- populate the dbo.emp table with the following two employees
-- first_name: Scot, Miriam
-- last_name: Davis, Yardley
-- hire_date: Dec-11-2020, Dec-5-2020
-- dept_id: 1,1
-- Hints: Do not specify emp_id in the insert statement due to the identity property and use 'YYYYMMDD'format
INSERT INTO dbo.emp(first_name,last_name,hire_date,dept_id)
       VALUES('Scot','Davis','20201211',1);
	        -- ('Miriam','Yardley','20201205',1);
SELECT * 
FROM dbo.emp;
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Update Statement
-- Update of table
-- challenge:Change Miriam's last_name from 'Yardley' to 'Greenbank' in the dbo.emp table. identify Miriam by her emp_id number in the WHERE clause of
-- the update statement.
UPDATE dbo.emp
SET first_name = 'Greenbank'
WHERE emp_id = 2;

SELECT *
FROM
dbo.emp;
------------------------------------------------------------------------------------------------------------------------------------------------------------
--DELETE STATEMENT
-- challenge
-- delete employee "Scott Davis' from dbo.emp table by his emp_id
DELETE dbo.emp
WHERE emp_id = 1;
-----------------------------------------------------------------------------------------------------------------------------------------------------------