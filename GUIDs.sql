USE SAMPLEDB

GO

-- Selecting GUIDS value by using NEWID() function

SELECT NEWID() AS guid_value;
GO

CREATE TABLE subjects1(
                       subject_id INT IDENTITY,
					   subject_name VARCHAR(20),
					   global_id UNIQUEIDENTIFIER,
					   CONSTRAINT pk_subject_id PRIMARY KEY (subject_id)
                     );
GO


INSERT INTO subjects1(subject_name,global_id)
             VALUES('Biology',NEWID()),
			       ('Physiscs',NEWID()),
				   ('English',NEWID());
GO




-- Here  global unique identifier is automatically generated as NEWDID() is set as default
CREATE TABLE dbo.subjects2 ( 
                           subject_id INT IDENTITY,
						   subject_name VARCHAR(20),
						   global_id UNIQUEIDENTIFIER DEFAULT NEWID(),
						   CONSTRAINT pk_subject2_subject_id PRIMARY KEY (subject_id)
                           );


INSERT INTO dbo.subjects2 (subject_name)
                  VALUES('Biology'),
				        ('Physics'),
						('English');

-- Creating GUIDs value using sequential approach
CREATE TABLE subjects3 (
             subject_id INT IDENTITY,
			 subject_name VARCHAR(20),
			 global_id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),
			 CONSTRAINT pk_subjects3_subject_id PRIMARY KEY (subject_id)
			          );
GO

INSERT INTO dbo.subjects3(subject_name)
            VALUES('Biology'),
			      ('Physics'),
				  ('English');
SELECT * 
FROM subjects3;

--------------------------------------------------------------------------------------------------------------------------------------------------------------