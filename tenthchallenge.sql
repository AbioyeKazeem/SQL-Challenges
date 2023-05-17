
USE SAMPLEDB

GO

-------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM bird.california_sightings;

SELECT *
FROM bird.arizona_sightings;

-- Challenge1
-- Return all rows from both the bird.california_sightings table and the bird.arizona_sightings table.
-- Use column names from the bird.california_sightings table
-- Hint: Use Union Operator

SELECT sighting_id, common_name,scientific_name, location_of_sighting, sighting_date
FROM bird.california_sightings
UNION ALL
SELECT sighting_id, common_name,scientific_name,sighting_location, sighting_date
FROM
bird.arizona_sightings;

--------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge2
-- Return all unique species as identified by the scientific_name column - for species which have been sighted in either california or arizona.
-- Use column names from the bird.california_sightings table
-- Hint: Use Union Operator

SELECT scientific_name
FROM bird.california_sightings
UNION 
SELECT scientific_name
FROM bird.arizona_sightings


---------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge3
-- Return all unique combinations of species(scientific_name) and state_name. The state_name will need to be added on as a new expression
-- which gives the applicable_state_name, use column names from the bird.california_sightings table.
-- order by state_name and scientific_name in ascending order
-- Hint: Use Union

SELECT scientific_name, 'California' AS state_name
FROM bird.california_sightings
UNION
SELECT scientific_name, 'Arizona' AS state_name
FROM bird.arizona_sightings
ORDER BY state_name, scientific_name ASC;

---------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge4 
-- return all rows from all the bird sightings tables i.e. Arizona, California and Florida
--Hint: use NULLS for the florida sightings common_name column as this column is not in Florida sightings table. 
-- include state_name as a column expression.

SELECT sighting_id, common_name,scientific_name, location_of_sighting, sighting_date, 'California' AS state_name
FROM bird.california_sightings
UNION ALL 
SELECT sighting_id, common_name,scientific_name, sighting_location, sighting_date, 'Arizona' AS state_name
FROM bird.arizona_sightings
UNION ALL
SELECT observation_id, NULL AS common_name, scientific_name, locality, CAST(sighting_datetime AS DATE) , 'California' AS state_name
FROM bird.florida_sightings;

---------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.customers;

SELECT *
FROM oes.orders;

-- Challenge5 
-- Return all unique customer IDs for customers who have placed orders
-- Hint: Use Intersect to get customer id's in common between the oes.customers table and oes.orders table

SELECT customer_id
FROM oes.customers
INTERSECT
SELECT customer_id
FROM oes.orders;

----------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.products;

SELECT *
FROM oes.inventories;

--Challenge6
-- Return all unique product ids for products that are currently not in stock 
-- Hint: Use the EXCEPT operator to select product ids in the oes.products table except those that are in the oes.inventories table.

SELECT product_id
FROM oes.products
EXCEPT
SELECT product_id
FROM oes.inventories;
-----------------------------------------------------------------------------------------------------------------------------------------------