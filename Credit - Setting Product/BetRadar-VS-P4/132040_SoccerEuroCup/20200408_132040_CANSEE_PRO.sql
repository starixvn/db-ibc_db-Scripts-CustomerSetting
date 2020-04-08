/*
	Created: Tiara
	Task: Update CanSee BetRadar VS 2 - Phase 4 PRO [RedmineID: #132040]
	DB: DBCUST/CustDB
	Date: 20200408
*/ 
USE CustDB
GO

--Update IsTest = 0, IsLaunched = 1 for all sites, all currencies
UPDATE PS
SET PS.IsTest = 0, ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency PS WITH (ROWLOCK,UPDLOCK)
WHERE SportType IN (197)

--Offer all currency for site BEST-ODDS
UPDATE PS
SET PS.Currency = 0
FROM dbo.ProductLaunchedSiteCurrency PS WITH (ROWLOCK,UPDLOCK)
WHERE PS.SportType IN (197) AND PS.SiteID = 1
