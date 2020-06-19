/*
	Created: 20200421@Elodie
	Task: Insert CanSee for GTCasino [Redmine: #130689] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @SiteID INT
SELECT @SiteID = 487


UPDATE p
SET IsLaunched = 1
FROM ProductLaunchedSiteCurrency p
WHERE SportType IN (243) AND siteid = @SiteID

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 242



