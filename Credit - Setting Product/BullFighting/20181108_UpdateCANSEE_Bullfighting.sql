/*
	Created: Elodie 
	Task: Not offer BullFighting anymore
	DB: DBCUST/CustDB
	Date: 20181108
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 207

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype