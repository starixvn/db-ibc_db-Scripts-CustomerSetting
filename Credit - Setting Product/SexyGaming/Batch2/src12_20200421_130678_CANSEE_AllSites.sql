/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for all sites - Batch 2 [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200421
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

--Offer supported currencies on all sites 
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (6,78,69,13,66,81,45) --Euro, EUR; MMK, RMB, CY, YUN, WON



