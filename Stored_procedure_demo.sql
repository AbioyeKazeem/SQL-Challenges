USE SAMPLEDB
GO


-- Select all employees from the 'Finance' department:
SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name 
	FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';


GO

-- Stored procedure with one input parameter:
CREATE PROCEDURE hcm.getEmployeesByDepartment (@department_name VARCHAR(50))
AS
SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name 
	FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = @department_name;

GO

-- Execute hcm.getEmployeesByDepartment stored procedure to get 
-- all employees in the 'Finance' department:
EXECUTE hcm.getEmployeesByDepartment @department_name = 'Finance';

-- or:
EXECUTE hcm.getEmployeesByDepartment 'Finance';

-- or:
EXEC hcm.getEmployeesByDepartment 'Finance';


-- Execute hcm.getEmployeesByDepartment stored procedure to get 
-- all employees in the 'Sales' department:
EXEC hcm.getEmployeesByDepartment @department_name = 'Sales';


-- SELECT query that selects customers who contain the string '34th' in their street address:
SELECT 
	customer_id,
	first_name,
	last_name,
	email,
	street_address
FROM oes.customers
WHERE street_address LIKE '%34th%';

GO


CREATE PROCEDURE oes.searchCustomersByStreetAddress
(
@street_address_search VARCHAR(50)
)
AS
SELECT 
	customer_id,
	first_name,
	last_name,
	email,
	street_address
FROM oes.customers
WHERE street_address LIKE '%' + @street_address_search + '%';
GO


-- Execute the oes.searchCustomersByStreetAddress stored procedure:
EXEC oes.searchCustomersByStreetAddress @street_address_search = '34th';

GO

-- SELECT query that selects customers from Australia who have gmail email addresses:
SELECT 
	cu.customer_id,
	cu.first_name,
	cu.last_name,
	cu.email,
	ct.country_name
FROM oes.customers cu
INNER JOIN hcm.countries ct
ON cu.country_id = ct.country_id
WHERE ct.country_name = 'Australia'
AND cu.email LIKE '%gmail.com';


-- We can put the value for the country name in a input parameter as well as the search string value for email domain
-- by creating the following stored procedure:

GO

CREATE PROCEDURE oes.getCustomersByCountryEmail
(
	@country VARCHAR(50),
	@email_domain VARCHAR(320)
)
AS

BEGIN

SELECT 
	cu.customer_id,
	cu.first_name,
	cu.last_name,
	cu.email,
	ct.country_name
FROM oes.customers cu
INNER JOIN hcm.countries ct
ON cu.country_id = ct.country_id
WHERE ct.country_name = @country
AND cu.email LIKE '%' + @email_domain;

END

GO

-- Execute the stored procedure to return customers from Australia with gmail email addresses:
EXEC oes.getCustomersByCountryEmail @country='Australia', @email_domain='@gmail.com';


-- Select employees who have a salary greater than or equal to 80000 and less than or equal 100000:
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees 
WHERE salary >= 80000
AND salary <= 100000;

GO


CREATE PROCEDURE hcm.getEmployeesBySalaryRange
(
@min_salary DECIMAL(12,2),
@max_salary DECIMAL(12,2)
)
AS
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees 
WHERE salary >= @min_salary
AND salary <= @max_salary;

GO



EXEC hcm.getEmployeesBySalaryRange @min_salary = 80000, @max_salary = 100000;

GO


/*
-- optional parameters:
We can specify default values for parameters. In alter procedure below,
@min_salary is set to a default value of 0 and @max_salary is set to a default value of 99999999.
Therefore, when you execute the stored procedure you have the option to skip the parameters 
which have default parameters.
*/

GO

ALTER PROCEDURE hcm.getEmployeesBySalaryRange
(
@min_salary DECIMAL(12,2) = 0,
@max_salary DECIMAL(12,2) = 99999999
)
AS
SELECT 
	employee_id,
	first_name,
	last_name,
	department_id,
	salary
FROM hcm.employees 
WHERE salary >= @min_salary
AND salary <= @max_salary;

GO


-- Select employees between default salary range i.e. @min_salary=0 and @max_salary=99999999:
EXEC hcm.getEmployeesBySalaryRange;


-- Select employees with min salary of 90000 and default max salary:
EXEC hcm.getEmployeesBySalaryRange @min_salary = 90000;

-- Select employees with max salary of 150000 and default min salary:
EXEC hcm.getEmployeesBySalaryRange @max_salary = 150000;



SELECT *
FROM dbo.parks2;
-- Output parameters:
/*
select *
from dbo.parks2

-- Create table called parks2:

CREATE TABLE dbo.parks2 
	(
	park_id INT IDENTITY(1,1),
	park_name VARCHAR(50) NOT NULL,
	entry_fee DECIMAL(6,2) NOT NULL,
	CONSTRAINT PK_parks2_park_id PRIMARY KEY (park_id)
	);


-- Populate parks2 table with some data:
INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Bellmont Park', 5);

INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Redmond Park', 10);

INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Highland Mountains', 6.75);

select *
from dbo.parks2;
*/

GO

CREATE PROCEDURE dbo.addNewPark
(
@park_name VARCHAR(50),
@entry_fee DECIMAL(6,2) = 0,
@new_park_id INT OUT
)
AS

-- Setting the NOCOUNT option to ON means that SQL Server won't show messages reporting how many rows were affected by DML statements:
SET NOCOUNT ON;

-- If XACT_ABORT setting is OFF then not all run-time errors will cause the transaction to rollback.
-- By setting XACT_ABORT setting ON then all errors will cause the transaction to rollback and execution of the code to abort:
SET XACT_ABORT ON;

BEGIN

INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES (@park_name, @entry_fee);


-- Setting the @new_park_id output parameter to the value returned by the SCOPE_IDENTITY function.
-- SCOPE_IDENTITY() returns the IDENTITY value of the last insert that occurred in the same scope:
SELECT @new_park_id = SCOPE_IDENTITY();

END

GO


/*
To execute a stored procedure with an output parameter(s), we must 
declare a variable to store the value returned by the output parameter:
*/

-- Declare a variable called @ParkID of data type INT. 
-- This will store the value returned by the @new_park_id ouput parameter:
DECLARE @ParkID INT;
 
-- Execute the stored procedure to add the 'Green Meadows' park.
EXEC dbo.addNewPark @park_name = 'Green Meadows', @entry_fee = 5, @new_park_id = @ParkID OUT;
 
SELECT @ParkID;

/*
Notes: 
We set the output parameter (@new_park_id) to the variable (@ParkID). 
Importantly, we need to include the keyword OUT or OUTPUT after setting any output parameters!
If we don't put the OUT keyword after setting output parameter in the execute statement then the
variable will not receive the value from the output paramater.
*/


SELECT *
FROM dbo.parks2;



































