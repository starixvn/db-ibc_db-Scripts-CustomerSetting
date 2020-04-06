/*
	Created: Elodie
	Date: 20200406
	Task: Update CanSee for Saba.club - 789y site, UUS
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT
SELECT @Sporttype = 200, @Bettype = 1611

UPDATE ps
SET ps.IsTest = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype

UPDATE ps
SET ps.Currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND SiteID = 3



