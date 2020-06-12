/*
	Created: 20200421@Elodie
	Task: Insert CanSee for GTCasino [Redmine: #130689] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT, @SiteID INT
SELECT @Sporttype = 242, @Bettype = 3201, @SiteID = 487


UPDATE p
SET IsLaunched = 1
FROM ProductLaunchedSiteCurrency p
WHERE SportType = @Sporttype AND bettype = @Bettype AND siteid = @SiteID AND currency = 20

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 242



