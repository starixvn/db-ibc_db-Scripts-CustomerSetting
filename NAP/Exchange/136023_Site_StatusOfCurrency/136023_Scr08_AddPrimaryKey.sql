/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 8.Add new Primary Key.
ALTER TABLE dbo.Exchange 
ADD CONSTRAINT PK_ExchangeId PRIMARY KEY CLUSTERED (ExchangeId)

