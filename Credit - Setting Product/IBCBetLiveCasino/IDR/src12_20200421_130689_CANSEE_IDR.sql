/*
	Created: 20200421@Elodie
	Task: Insert CanSee for GTCasino [Redmine: #130689] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 242, @Bettype = 3201


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

--20,15,22,33,34,47
INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 15 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 22 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 33 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 34 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 47 AS Currency, 487 AS SiteID, 1 AS IsLaunched, 0 AS IsTest 

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 242



