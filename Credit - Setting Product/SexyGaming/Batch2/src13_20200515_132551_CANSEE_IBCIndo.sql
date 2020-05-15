/*
	Created: 20200515@Tiara
	Task: Insert CanSee Sexy Gaming for batch 2- IBC Indo [Redmine: #132551]
	DB: DBCUST/CustDB
	Date: 20200515
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

CREATE TABLE #Exchange (ExchangeID INT PRIMARY KEY)
INSERT INTO #Exchange (ExchangeID)
SELECT DISTINCT E.exchangeid
FROM exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (3,15,22,33,34,47)
----Offer supported site and supported currencies
CREATE TABLE #ProductLaunchedSiteCurrency (SportType SMALLINT, Currency INT, SiteID INT, IsLaunched BIT, IsTest INT, BetType SMALLINT)
INSERT INTO #ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.ExchangeID AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK) CROSS JOIN #Exchange E WITH (NOLOCK)
WHERE S.siteid = 487 --IBCIndo

--INSERT DATA
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT SportType, Currency, SiteID, IsLaunched, IsTest, BetType
FROM #ProductLaunchedSiteCurrency P WITH (NOLOCK)

DROP TABLE #Exchange
DROP TABLE #ProductLaunchedSiteCurrency

