/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for batch 1 - BEST-ODDS, 789y - YNG [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200321
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype
----Offer site BEST-ODDS, 789y - YNG
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 72 AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK)
WHERE S.siteid IN (1,3)




