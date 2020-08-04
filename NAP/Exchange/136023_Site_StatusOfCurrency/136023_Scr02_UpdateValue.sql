/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE CustDB
GO

-- 2.Update the new column with the same values.
UPDATE Exchange WITH (ROWLOCK)
SET NewExchangeid = ExchangeId