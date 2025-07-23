/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250627
	Task: initial data into Company Bet Limit for GPI Lottery [Redmine: #231521] 
	DB:	DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, RepUpdateTime)
	  SELECT 132,		2,		1,		0.5,	5000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		2,		2,		50000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		3,		0.1,	1000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		4,		1,		10000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		5,		1,		10000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		6,		1,		10000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		7,		5,		50000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		8,		150,	1500000,	dbo.f_Getdatetime2()
UNION SELECT 132,		2,		9,		3,		30000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		12,		5,		50000,		dbo.f_Getdatetime2()
UNION SELECT 132,		2,		13,		0.1,	1000,		dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 132,		2,		4,		0.1,	1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 132,		2,		7,		2,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 132,		2,		5,		0.5,	5000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 132,		2,		2,		0.1,	1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 132,		2,		13,		3,		30000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 132,		2,		6,		1,		10000,		0,		 dbo.f_Getdatetime2()
GO
