/*
	Created: Tiara
	Task: Update CanSee SA Gaming for HK$, RMB, HKK [Redmine: #134176]
	DB: DBCUST/CustDB
	Date: 20200322
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001


--Update IsLaunched = 0 for HK$, RMB, HKK
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (13,5,67) AND PS.IsLaunched = 1


