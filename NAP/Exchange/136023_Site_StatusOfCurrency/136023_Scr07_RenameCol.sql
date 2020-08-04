/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 7.Rename column.
EXEC SP_RENAME 'Exchange.NewExchangeId', 'ExchangeId', 'COLUMN'
