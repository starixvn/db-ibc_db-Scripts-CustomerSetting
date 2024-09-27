/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240927
	Task: Jili/ PG Soft - Adjust betlimit [Redmine:#211345] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 158,	1,	24,		0.01,	1000,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	1,	15,		0.01,	100000,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	1,	17,		0.01,	5000,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	1,	20,		0.01,	100000,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	2,	24,		0.01,	500,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	2,	15,		0.01,	50000,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	2,	17,		0.01,	2500,		0,	dbo.f_GetDateTime2()
UNION SELECT 158,	2,	20,		0.01,	50000,		0,	dbo.f_GetDateTime2()
UNION SELECT 232,	1,	24,		0.01,	1000,		0,	dbo.f_GetDateTime2()
UNION SELECT 232,	1,	35,		0.01,	1000,		0,	dbo.f_GetDateTime2()
GO