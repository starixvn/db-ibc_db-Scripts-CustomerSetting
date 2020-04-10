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
SELECT 0,20,219,1,1, 1011, 0

