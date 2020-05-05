/*
	Created: 20200504@Eden
	Task: Insert CanSee for ION UUS, YNG [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
			SELECT 20 --UUS
UNION ALL SELECT 72 --YNG

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferCurrency t ON p.Currency = t.ExchangeID
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, t.ExchangeID AS Currency, 0 AS SiteID, 1 AS IsLaunched, 0 AS IsTest 
FROM #OfferCurrency t

DROP TABLE #OfferCurrency

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 225



