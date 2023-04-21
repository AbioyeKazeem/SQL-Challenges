
USE SAMPLEDB
GO

-- USING SELECT DISTINCT TO ELIMINATE DUPLICATE VALUE IN SQL 
-- Second challenge
SELECT *
FROM bird.antarctic_populations;


-- second challenge A
SELECT DISTINCT locality
FROM bird.antarctic_populations;



-- Second challenge B
SELECT DISTINCT locality, species_id
FROM bird.antarctic_populations;
