/*
	Created: 20200623@Eden
	Task: Update CanSee SA Gaming for HKK,HK$ - ROLLBACK [Redmine: #128058]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001

--Offer  HKK,HK$
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (5,67) -- HK$,HKK

