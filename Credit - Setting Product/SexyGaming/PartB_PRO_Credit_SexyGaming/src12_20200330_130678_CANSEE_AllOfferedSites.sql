/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for batch 2- all offered sites [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200330
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

CREATE TABLE #Exchange (ExchangeID INT PRIMARY KEY)
INSERT INTO #Exchange (ExchangeID)
SELECT DISTINCT E.exchangeid
FROM exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (17,3,64,16,40,2,47,33,34,15,22,4,43)
----Offer supported site and supported currencies
CREATE TABLE #ProductLaunchedSiteCurrency (SportType SMALLINT, Currency INT, SiteID INT, IsLaunched BIT, IsTest INT, BetType SMALLINT)
INSERT INTO #ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (11) AND E.ExchangeID = 3 -- Indo
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (1,3) AND E.ExchangeID IN (17,3,64,16,40)--  Best-odds - 789y
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (13,1,23,24,16,20,21,22,184,188) AND E.ExchangeID IN (2) --XYZBET, Best-odds, 222223, 222225, 611111, 722222, 733333,755555,766666,7aa666
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (11) AND E.ExchangeID IN (47,33,34,15,22) --Indo
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (1) AND E.ExchangeID IN (15) -- Best-odds
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (13,25,16) AND E.ExchangeID IN (4) --xyzbet, 222227,611111
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (1,22) AND E.ExchangeID IN (4,43) --Best-odds, 755555

--INSERT DATA
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT SportType, Currency, SiteID, IsLaunched, IsTest, BetType
FROM #ProductLaunchedSiteCurrency P WITH (NOLOCK)

DROP TABLE #Exchange
DROP TABLE #ProductLaunchedSiteCurrency




