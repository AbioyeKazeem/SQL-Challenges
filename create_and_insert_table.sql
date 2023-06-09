USE SAMPLEDB

GO
SELECT 3/2;

SELECT 3/2.0;

SELECT  2147483649 / 2;

-- Declaring a variable called @val of decimal (12,2) data type and giving it a value of 0.0 using a while loop to add 0.1 to val which will continue iterating
-- while @val does not equal to 10.0
-- Use Declare keywords to declare a variable in SQL

Declare @val DECIMAL(12,2) = 0.0;
WHILE @val != 10.0
BEGIN
PRINT @val;
SET @val += 0.1;
END;


Declare @vals FLOAT(24) = 0.0;
WHILE @vals != 10.0
BEGIN
   PRINT str(@vals, 20, 16);
   SET @vals += 0.1;
END;


-- You can't create a table by starting with number or any special character.
CREATE TABLE parks1 
(
park_id INT,
park_name VARCHAR(50),
entry_fee DECIMAL(6,2)
);


SELECT *
FROM dbo.parks1;


INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
            VALUES(1, 'Bellmont park', 5);

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
            VALUES(2, 'Redmond park', 10);

INSERT INTO parks1 (park_id, park_name, entry_fee)
            VALUES(3, 'Highland Mountains', 6.74);


CREATE TABLE dbo.parks2 (
                  park_id INT IDENTITY(1,1),
				  park_name VARCHAR(50) NOT NULL,
				  entry_fee DECIMAL(6,2) NOT NULL, 
                  CONSTRAINT Pk_parks2_park_id PRIMARY KEY (park_id)
		            );

SELECT *
FROM dbo.parks2;


-- INSERT INTO A TABLE BY ADDING IDENTITY (1,1) 2 EFFECT AUTO-INCREMENT OF THE PRIMARY KEY COLUMN OF A TABLE WITHOUT THE NEED TO CREATE IT MANUA
INSERT INTO dbo.parks2(park_name, entry_fee)
            VALUES('Bellmont park', 5);

INSERT INTO dbo.parks2 (park_name, entry_fee)
            VALUES('Redmond park', 10);

INSERT INTO parks2(park_name, entry_fee)
            VALUES('Highland Mountains', 6.74);

CREATE TABLE dbo.park_visits(
                             visit_id INT IDENTITY(1,1), 
							 park_id INT NOT NULL,
							 visit_date DATE NOT NULL,
							 first_name NVARCHAR(50) NOT NULL,
							 last_name NVARCHAR(50) NOT NULL,
							 CONSTRAINT PK_park_visits_visit_id PRIMARY KEY (visit_id),
							 CONSTRAINT FK_park_visits_park_id FOREIGN KEY (park_id) REFERENCES parks2 (park_id)
                            );

INSERT INTO dbo.park_visits(park_id, visit_date, first_name,last_name)
            VALUES(2,'20200109','Bill', 'Evans');

INSERT INTO dbo.park_visits(park_id, visit_date, first_name,last_name)
            VALUES(1,'20201122','Jane', 'Dillion');

INSERT INTO dbo.park_visits(park_id, visit_date, first_name,last_name)
            VALUES(1,'20200623','Mike', 'Cruz');

INSERT INTO dbo.park_visits(park_id, visit_date, first_name,last_name)
            VALUES(3,'20200520','Irene', 'Pritchard');

-- The foreign key prevented the following row from being inserted cos the park_id with 99 does not exist parks2 table which is the parent table.
INSERT INTO dbo.park_visits(park_id, visit_date, first_name,last_name)
            VALUES(99,'20200520','Helen', 'Turner');

SELECT * 
FROM dbo.park_visits;

-- Note when using a foreign key in table creation constraint, you must reference the primary key of the table you are referencing.
CREATE TABLE dept(
dept_name NVARCHAR(50) NOT NULL,
loc_id INT NOT NULL,
CONSTRAINT FK_dept_location_id FOREIGN KEY (loc_id) REFERENCES hcm.departments (department_id)
);

-- USING INSERT INTO --- SELECT STATEMENT TO INSERT INTO NEW TABLE FROM ANOTHER TABLE(S)
-- EXAMPLE
INSERT INTO dept(dept_name,loc_id)
SELECT department_name,location_id
FROM hcm.departments
WHERE department_name = 'IT';
