/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 3.Set the new column as NOT NULL.

ALTER TABLE Exchange ALTER COLUMN NewExchangeid INT NOT NULL