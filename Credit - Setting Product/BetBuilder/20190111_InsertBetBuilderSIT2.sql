
/*
	Created: Winnie
	Date: 20190111
	Task: BetBuilder [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

DELETE FROM ProductLaunchedSiteCurrency
	WHERE SportType=1 AND BetType=38

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType],BetType, [IsLaunched], [IsTest],LaunchedLevel)
SELECT [SiteID], 20, 1,38, 1, 0,1
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1 AND site='BEST-ODDS'


