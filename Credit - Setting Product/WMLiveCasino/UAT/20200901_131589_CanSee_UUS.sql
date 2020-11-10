/*
	Created: Winfred
	Date: 20200828
	Task: Insert CanSee for WM UUS [Redmine: 131589]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 233, @Bettype = 3401

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
		  SELECT 20	--UUS
UNION ALL SELECT 72 --YNG

SELECT c.ExchangeID,s.siteid
INTO #OfferedSiteCurrency
FROM #OfferCurrency c
	CROSS APPLY Site s WITH(NOLOCK)
WHERE s.isLicensee = 0 AND s.isActive = 1  AND site NOT IN ('CN88')

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferedSiteCurrency t ON p.Currency = t.ExchangeID AND p.SiteID = t.siteid
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, t.ExchangeID AS Currency, siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest 
FROM #OfferedSiteCurrency t

DROP TABLE #OfferCurrency
DROP TABLE #OfferedSiteCurrency





