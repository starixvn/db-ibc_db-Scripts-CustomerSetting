/*
	Created: Tiara
	Task: Rollback CanSee Sexy Gaming IBCIndo [Redmine: #132551]
	DB: DBCUST/CustDB
	Date: 20200515
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101


UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype 
	AND PS.IsLaunched = 1 
	AND PS.SiteID = 487 --IBCIndo
