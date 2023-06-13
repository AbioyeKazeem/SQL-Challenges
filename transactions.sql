
USE SAMPLEDB

GO


-- Dealing with Explicit transaction

-- BEGIN A NEW TRANSACTION
BEGIN TRANSACTION;

-- Declare a variable called new_product_id that will hold new product_id value.
DECLARE @new_product_id INT;

INSERT INTO oes.products(product_name,category_id,list_price,discontinued)
VALUES('PBX Printer',7,45.99,0);


-- The scope identity return the last value inserted into the Identity column
SET @new_product_id = SCOPE_IDENTITY();

INSERT INTO oes.inventories(product_id, warehouse_id, quantity_on_hand)
VALUES(@new_product_id,1,100),
      (@new_product_id,4,35);


-- Commit the changes (last statement) using commit transaction or commit
-- commit happen if both insert statements are successful.
COMMIT TRANSACTION;

SELECT *
FROM oes.products;

SELECT * 
FROM oes.inventories;