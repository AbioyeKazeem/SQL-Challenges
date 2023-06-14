/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) account_id,account_name,balance
  FROM oes.bank_accounts;