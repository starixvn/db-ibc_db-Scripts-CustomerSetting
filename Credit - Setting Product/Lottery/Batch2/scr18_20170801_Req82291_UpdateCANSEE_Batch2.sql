/*
	Created: Elodie 
	Task: Insert CanSee Lottery for batch 1
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 220

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0



