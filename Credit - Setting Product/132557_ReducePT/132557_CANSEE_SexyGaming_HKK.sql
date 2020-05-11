/*
	Created: Elodie
	Task: CanSee Sexy Gaming for HKK [Redmine: #132557]
	DB: DBCUST/CustDB
	Date: 20200511
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (67)


