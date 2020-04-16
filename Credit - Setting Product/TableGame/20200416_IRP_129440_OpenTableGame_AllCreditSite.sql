/*
	Created: Elodie
	Task: Enable can-see status of Table Game
	DB: DBCUST/CustDB
	Date: 20200416
*/ 
USE CustDB
GO

DELETE ProductLaunchedSiteCurrency WITH(ROWLOCK) WHERE SportType=222

INSERT INTO ProductLaunchedSiteCurrency (SiteID,Currency,SportType,IsLaunched,IsTest, BetType, LaunchedLevel)
SELECT SiteID,Currency,222,IsLaunched,IsTest, 4901, LaunchedLevel
FROM ProductLaunchedSiteCurrency WITH (NOLOCK)
WHERE SportType = 220

