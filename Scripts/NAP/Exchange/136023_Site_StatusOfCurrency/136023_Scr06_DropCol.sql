/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 6.Drop IDENTITY column.
ALTER TABLE Exchange DROP COLUMN Exchangeid 