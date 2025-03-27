/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250307
	Task: initial data into Company Bet Limit for Funky Games - UUS [Redmine:#218180] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

IF @@SERVERNAME = 'SITDBCUST'
	USE GlobCustDB
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 131,	1,	6,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	6,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 131,	1,	6,		0.01,	500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	6,		0.01,	500,	0,	 dbo.f_Getdatetime2()
GO