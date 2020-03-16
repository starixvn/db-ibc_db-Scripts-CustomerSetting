/*
	Created: Tiara
	Date: 20200316
	Task: Update CANSEE launchlevel = 1 ( by bettype)
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT 
SELECT @Sporttype = 244, @Bettype = 3001


UPDATE ps
SET ps.LaunchedLevel = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype 


