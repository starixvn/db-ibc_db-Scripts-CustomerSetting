/*
	Created: Winnie
	Date: 20181123
	Task: VS Betradar 3 - Virtual Soccer Asian Cup [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest])
SELECT [SiteID], 0, 194, 1, 1
FROM Site (nolock)
where isLicensee = 0 and isDeposit = 0
and isActive = 1
