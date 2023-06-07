USE SAMPLEDB

GO

---------------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge1
-- Select the following columns from oes.products table
-- product_id, product_name, discontinued
-- include a CASE expression in a SELECT statement called discontinued_description. Give the expression the string 'No' when the discontinued column equal 0 and
-- a string 'Yes' when the discontinued column equals 1. In all other cases give the expression the string of 'unknown'.
SELECT 
product_id, product_name, discontinued,
CASE
WHEN discontinued = 0 THEN 'No'
WHEN  discontinued = 1 THEN 'Yes'
ELSE 'unknown'
END AS discontinued_description
FROM oes.products;

-- OR

SELECT 
product_id, product_name, discontinued,
CASE discontinued
WHEN 0 THEN 'No'
WHEN 1 THEN 'Yes'
ELSE 'unknown'
END AS  discontinued_description
FROM oes.products;



---------------------------------------------------------------------------------------------------------------------------------------------------
-- challenge2 
-- select the following columns from the oes.products table:
-- product_id, product_name,list_price
-- include a CASE expression in the SELECT statement called price_grade. For this expression
-- if list_price is less than 50 then give the string 'Low'.
-- if list_price is greater than or equal to 50 and list_price is less than 250 then give the string 'Medium'.
-- if list_price is greater than or equal to 250 then give string 'High'
-- in all other cases, give the expression the string of 'unknown'.
--Hint: Use the searched form of the CASE expression. Also, remember that the WHEN clauses are evaluated in the order they are written

SELECT product_id, product_name, list_price,
CASE 
WHEN list_price <50 THEN 'Low'
WHEN  list_price >= 50 AND  list_price < 250 THEN 'Medium'
WHEN list_price >= 250 THEN 'High'
ELSE 'unknown'
END AS price_grade
FROM oes.products;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- challenge3 
-- select the following columns from oes.orders table:
-- order_id, order_date, shipped_date
-- include a CASE expression called shipping_status which determines the difference in days between the order_date and the shipped_date.
-- When this difference is less than or equal to 7 then give the string value 'Shipped within one week'
-- if the difference is greater than 7 days, then give the string 'shipped over a week later'.
-- if shipped_date is null then give the string 'Not yet shipped'.
-- Hint: Use the DATEDIFF function to determine the difference in days between the order_date and shipped_date attributes.
-- DATEDIFF(interval,date1,date2)

SELECT order_id, order_date, shipped_date,
CASE
WHEN DATEDIFF(day,order_date,shipped_date)  <= 7 THEN 'Shipped within one week'
WHEN DATEDIFF(day,order_date,shipped_date)  > 7 THEN 'Shipped over a week later'
WHEN DATEDIFF(day,order_date,shipped_date) IS NULL THEN 'Not Yet shipped'
END AS shipping_status
FROM oes.orders;

-- OR

SELECT o.order_id, o.order_date,o.shipped_date,o.shipping_status
FROM ( SELECT order_id,order_date,shipped_date,
CASE
WHEN DATEDIFF(day,order_date,shipped_date) <= 7 THEN 'Shipped within one week'
WHEN DATEDIFF(day,order_date,shipped_date) > 7 THEN 'Shipped over a week later'
WHEN DATEDIFF(day,order_date,shipped_date) IS NULL THEN 'Not Yet shipped'
ELSE 'unknown'
END AS shipping_status 
FROM oes.orders
     ) o;

-- OR
-- You can also use Common Table Expression Approch(CTE)

-----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM oes.orders;

-- challenge4
-- Repeat the third challenge to derive the shipping_status expression, but this time get the count of orders by the shipping_status expression.
-- Put the query from the third challenge into either subquery (i.e derived table) or a common table expression(CTE).
-- in the outer query use a GROUP BY clause to group the rows by the shipping_status expression and use the COUNT function to count the rows in each group.
-- Also, include the shipping_status in the SELECT clause of the outer query.

SELECT o.shipping_status,
Count(*) AS count_by_shipping_status
FROM ( SELECT 
CASE
WHEN DATEDIFF(day,order_date,shipped_date) <= 7 THEN 'Shipped within one week'
WHEN DATEDIFF(day,order_date,shipped_date) > 7 THEN 'Shipped over a week later'
WHEN DATEDIFF(day,order_date,shipped_date) IS NULL THEN 'Not Yet shipped'
END AS shipping_status 
FROM oes.orders
     ) o
GROUP BY shipping_status;

-- OR
WITH cte
AS
(
SELECT
CASE
WHEN DATEDIFF(day,order_date,shipped_date) <= 7 THEN 'Shipped within one week'
WHEN DATEDIFF(day,order_date,shipped_date) > 7 THEN 'Shipped over a week later'
WHEN DATEDIFF(day,order_date,shipped_date) IS NULL THEN 'Not Yet shipped'
END AS shipping_status 
FROM oes.orders
)
SELECT
shipping_status,
Count(*) AS count_by_shipping_status
FROM cte
GROUP BY shipping_status;
 
