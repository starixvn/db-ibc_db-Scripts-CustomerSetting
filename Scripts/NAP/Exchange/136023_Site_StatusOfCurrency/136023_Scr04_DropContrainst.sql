/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 4.Drop Primary Key.

ALTER TABLE Exchange DROP CONSTRAINT PK_exchange