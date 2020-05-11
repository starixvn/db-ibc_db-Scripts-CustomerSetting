/*
	Created: Eden
	Date: 20200109
	Task: Update CANSEE launchlevel = 1 ( by bettype)
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT 
SELECT @Sporttype = 245, @Bettype = 4601

--Offer site BEST-ODDS
UPDATE ps
SET ps.LaunchedLevel = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype 


