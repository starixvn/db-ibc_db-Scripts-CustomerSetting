/*
	Created: Winnie
	Date: 20181206
	Task: VS Betradar 3 - Virtual Soccer Asian Cup UUS [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest])
SELECT [SiteID], 20, 194, 1, 1
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1



