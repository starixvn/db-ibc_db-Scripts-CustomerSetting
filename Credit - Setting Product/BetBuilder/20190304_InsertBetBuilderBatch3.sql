
/*
	Created: Winnie
	Date: 20190305
	Task: BetBuilder Batch 3 [RedmineID: #105664] 
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

DELETE FROM ProductLaunchedSiteCurrency
WHERE SiteID IN(SELECT siteid FROM Site WITH(NOLOCK) WHERE site IN('755555' ,'789y'))
	AND SportType=1 AND BetType=38

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType],BetType, [IsLaunched], [IsTest],LaunchedLevel)
SELECT [SiteID], 0, 1,38, 1, 0,1
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1 AND site IN('755555' ,'789y')