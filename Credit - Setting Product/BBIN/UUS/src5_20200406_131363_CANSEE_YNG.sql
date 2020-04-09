/*
	Created: 20200406@Eden
	Task: Insert CanSee for BBIN YNG [Redmine: #131363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 241, @Bettype = 3300


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest, LaunchedLevel)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 72 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest, 1 AS LaunchedLevel

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 241



