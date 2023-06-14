
USE SAMPLEDB

GO
--stored_procedure challenges
----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
SELECT product_id, warehouse_id, quantity_on_hand
FROM oes.inventories
WHERE product_id = 4 AND warehouse_id = 2;
; */

-- first challenge
-- create a stored procedure called oes.getQuantityOnHand that returns the quantity_on_hand in the oes.inventories table for a given product_id and warehouse_id
-- also execute the stored procedure to return the quantity on hand of product id 2 at warehouse id 4.
-- define two input parameters i.e @product_id and @warehouse_id of same data type INT. Also reference all these parameters in the WHERE clause of the SELECT stmt.

CREATE PROCEDURE oes.getQuantityOnHand 
( @product_id INT,
  @warehouse_id INT
)
AS

BEGIN

SELECT quantity_on_hand
FROM oes.inventories
WHERE product_id = @product_id AND warehouse_id = @warehouse_id
END
GO

-- Executing the stored procedure
EXEC oes.getQuantityOnHand @product_id = 4,  @warehouse_id = 2;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- second challenge
-- Create a stored procedure called oes.getCurrentProducts that returns current products (discontinued = 0) in the oes.products table. 
-- In addition, define two input parameters 
-- a parameter called @product_name of data type VARCHAR(100), allow users to wildcard search on the product_name
-- a parameter called @max_list_price of data type(19,4). Allow users to only include current products that have a list_price that is less than or equal to a
-- specified value for this parameter.
-- Execute the the stored procedure to return the current products that contain the word 'Drone' and have a maximum price of $700
-- Hint: Recall that we can allow for wildcard searches by using the LIKE operator with '%' concatenated on to one or both sides of the input parameter
-- for example: WHERE first_name LIKE '%' + '%' + @name + '%'
-- also include another condition in the WHERE clause to check the list_price is less than or equal to the @max_list_price parameter

CREATE PROCEDURE oes.getCurrentProducts
(@product_name VARCHAR(100), @max_list_price DECIMAL(19,4)) 
AS 
BEGIN

SELECT 
product_id, product_name, list_price
FROM oes.products
WHERE discontinued = 0 AND product_name LIKE '%' + '%' + @product_name + '%' AND list_price <= @max_list_price

END;

-- Executing the stored procedure
EXEC oes.getCurrentProducts @product_name ='Drone', @max_list_price = 700;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.bank_accounts;

SELECT *
FROM oes.bank_transactions;

-- third challenge
-- create a stored procedure called oes.transferFunds that transfer money from one bank account to another bank account by updating the balance column 
-- in oes.bank_account table. Also,insert the bank transaction details into oes.bank_transactions table. Define 3 input parameters 
-- STEPS TO FOLLOW
-- @withdraw_account_id of data type INT
-- @deposit_account_id of data type INT
-- @transfer_amount of data type DECIMAL(30,2)
-- Test the stored procedure by transfering $100 from Anna's account into Bob's account, (oes.bank_accounts, oes.bank_transactions)
-- 1. update Anna's balance by reducing by the transfer amount;   
-- 2. update Bob's balance by increasing it by the transfer amount;
-- 3. insert the values from parameters into the matching columns into the bank_transactions table
-- remember to put all the 3 statements 
-- Begin Transaction; sql stmts; COMMIT Transaction

CREATE PROCEDURE oes.transferFunds
( @withdraw_account_id INT, 
  @deposit_account_id INT,
  @transfer_amount DECIMAL(30,2)
)
AS 

-- Setting the NOCOUNT option to ON means that SQL won't show messages reporting how
SET NOCOUNT ON 

-- IF XACT ABORT setting is OFF then not all run-time errors will cause the transactions to 
-- By setting XACT_ABORT setting ON then all errors will cause the transaction to roll back
SET XACT_ABORT ON

BEGIN


BEGIN TRANSACTION;

-- withdraw (debit) transfer amount from the 1st bank account
UPDATE oes.bank_accounts
SET balance = balance - @transfer_amount
WHERE account_id = @withdraw_account_id;

-- deposit(credit) transfer amount into the second bank
UPDATE oes.bank_accounts
SET balance = balance + @transfer_amount
WHERE account_id = @deposit_account_id;

-- insert the transaction details into oes.bank_transactions table
INSERT INTO oes.bank_transactions(from_account_id, to_account_id,amount)
VALUES(@withdraw_account_id, @deposit_account_id,@transfer_amount);

COMMIT TRANSACTION

END;

-- executing the stored procedure
EXEC oes.transferFunds @withdraw_account_id = 1, @deposit_account_id = 2, @transfer_amount = 100;
SELECT *
FROM oes.bank_accounts;

-----------------------------------------------------------------------------------------------------------------------------------------------------------