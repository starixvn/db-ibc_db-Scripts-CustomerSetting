/*
	Created: Winnie
	Date: 20190827
	Task: BetBuilder 'INDO', 'KORIBC' [RedmineID: #105664] 
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

DELETE FROM ProductLaunchedSiteCurrency
WHERE SiteID IN(SELECT siteid FROM Site WITH(NOLOCK) WHERE site IN('INDO', 'KORIBC'))
	AND SportType=1 AND BetType=38

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType],BetType, [IsLaunched], [IsTest],LaunchedLevel)
SELECT [SiteID], 0, 1,38, 1, 1,1
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1 AND site IN('INDO', 'KORIBC')
