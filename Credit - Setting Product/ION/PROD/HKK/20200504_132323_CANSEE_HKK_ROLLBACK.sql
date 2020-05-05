/*
	Created: 20200504@Eden
	Task: Insert CanSee for ION - HKK - ROLLBACK [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
SELECT 67 --HKK

UPDATE p
SET p.IsLaunched = 0
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferCurrency t ON p.Currency = t.ExchangeID
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

DROP TABLE #OfferCurrency

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 225



