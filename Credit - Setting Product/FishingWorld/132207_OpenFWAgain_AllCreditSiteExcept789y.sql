/*
	Created: Elodie
	Task: Fishing World - Enable can-see status for Fishing World again
	DB: DBCUST/CustDB
	Date: 20200410
*/ 
USE CustDB
GO

DELETE ProductLaunchedSiteCurrency WITH(ROWLOCK) WHERE SportType=219

INSERT INTO ProductLaunchedSiteCurrency (SiteID,Currency,SportType,IsLaunched,IsTest, BetType, LaunchedLevel)
SELECT SiteID,Currency,219,IsLaunched,IsTest, 1101, LaunchedLevel
FROM ProductLaunchedSiteCurrency WITH (NOLOCK)
WHERE SportType = 220

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
SET IsLaunched = 0
WHERE sporttype = 219
	AND siteid = 3
