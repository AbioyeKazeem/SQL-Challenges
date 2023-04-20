USE SAMPLEDB
GO

-- WHERE FUNCTION, ISNULL, COALESCE AND COMPARISON OPERATOR USAGE IN SQL
-- select all columns from oes.product tables
SELECT *
FROM oes.products;


-- (1).select product from oes.products which have a price greater than 100
SELECT * FROM oes.products
WHERE list_price > 100 ;



SELECT * FROM oes.orders;
 -- (2). select orders from oes.orders table which has not yet been shipped
--Hint this is an order where the shipped date is null
SELECT * FROM oes.orders
WHERE shipped_date IS NULL;



-- (3).select all orders oes.orders table which were placed on the 26th of February 2020.
-- Hint, in SQL when quarrying a column of data type date, you can use form 'YYYYMMDD'
-- e.g '20200425'
SELECT * from oes.orders
WHERE
order_date = '20200226';



-- select all orders from oes.orders table which were placed on or after the 1st of January 2020.
-- Hint when using comparison operators with dates, an old date is considered lower than a newer date
-- e.g '19900101' <  '20200505' later dates are greater ddates
SELECT * FROM oes.orders
WHERE order_date >='20200101';
