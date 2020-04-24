/*
	Created: 20200424@Tiara
	Task: Insert CanSee Sexy Gaming for batch 2- remaining currencies [Redmine: #132551]
	DB: DBCUST/CustDB
	Date: 20200424
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

CREATE TABLE #Exchange (ExchangeID INT PRIMARY KEY)
INSERT INTO #Exchange (ExchangeID)
SELECT DISTINCT E.exchangeid
FROM exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (6,69,13,45,12) --EURO,MMK,RMB,WON,GBP
----Offer supported site and supported currencies
CREATE TABLE #ProductLaunchedSiteCurrency (SportType SMALLINT, Currency INT, SiteID INT, IsLaunched BIT, IsTest INT, BetType SMALLINT)
INSERT INTO #ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (23,16,20,21,1,13) AND E.ExchangeID = 13 -- RMB
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (188) AND E.ExchangeID IN (69)--  MMK
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (1,13) AND E.ExchangeID IN (6,12) --EURO, GBP
UNION ALL
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid IN (1,35) AND E.ExchangeID IN (45) --Won

--INSERT DATA
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT SportType, Currency, SiteID, IsLaunched, IsTest, BetType
FROM #ProductLaunchedSiteCurrency P WITH (NOLOCK)

DROP TABLE #Exchange
DROP TABLE #ProductLaunchedSiteCurrency




