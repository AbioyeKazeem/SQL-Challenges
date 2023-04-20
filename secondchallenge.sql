
USE SAMPLEDB
GO

-- Second challenge
SELECT *
FROM bird.antarctic_populations;


-- second challenge A
SELECT DISTINCT locality
FROM bird.antarctic_populations;



-- Second challenge B
SELECT DISTINCT locality, species_id
FROM bird.antarctic_populations;
