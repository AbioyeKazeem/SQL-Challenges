USE SAMPLEDB

GO

-- ALTER TABLE challenges
----------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hcm.employees;
-- 1st challenge
-- Add a new column called 'termination_date' onto the hcm.employees table. Give this new column a data type of DATE.
-- Hint: Use ALTER TABLE ... ADD... statement
ALTER TABLE hcm.employees
ADD termination_date DATE;

----------------------------------------------------------------------------------------------------------------------------------------------
-- second challenge
-- Write two SQL statement to change the data type of the first_name and the last_name to NVARCHAR(60) in the oes.customers table.
-- Hint: Use two ALTER TABLE...ALTER COLUMN... statements One for each column

ALTER TABLE oes.customers
ALTER COLUMN first_name NVARCHAR(60);

ALTER TABLE oes.customers
ALTER COLUMN last_name NVARCHAR(60);

----------------------------------------------------------------------------------------------------------------------------------------------
-- third challenge
-- use sp_rename statement to rename column name 'phone' to 'main_phone' in the oes.customers table.
sp_rename 'oes.customers.phone', 'my_phone','COLUMN';

SELECT * 
FROM oes.customers;
----------------------------------------------------------------------------------------------------------------------------------------------