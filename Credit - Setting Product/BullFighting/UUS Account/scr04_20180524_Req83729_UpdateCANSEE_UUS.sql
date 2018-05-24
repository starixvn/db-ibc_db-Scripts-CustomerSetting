/*
	Created: Elodie 
	Task: Update CanSee BullFighting for UUS
	DB: DBCUST/CustDB
	Date: 20180524
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 207

--Offer UUS
UPDATE ps
SET IsTest = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype


