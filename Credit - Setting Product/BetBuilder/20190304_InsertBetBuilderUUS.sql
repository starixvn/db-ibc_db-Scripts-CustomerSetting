
/*
	Created: Winnie
	Date: 20190305
	Task: BetBuilder UUS [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType],BetType, [IsLaunched], [IsTest],LaunchedLevel)
SELECT [SiteID], 20, 1,38, 1, 1,1
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1


