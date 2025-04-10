/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250314
	Task: initial data into Company Bet Limit for HOTDOG  [Redmine:#219766] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 139,		1,		1,		0.01,		10000,		'Member site must NOT apply bet limits for HKD (HKK).'
																	,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		2,		0.01,		35000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		3,		0.01,		2500,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		7,		0.01,		75000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		8,		0.01,		1000000,	NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		9,		0.01,		50000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		10,		0.01,		3000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		11,		0.01,		2500000,	NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		12,		0.01,		100000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		13,		0.01,		2500,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		1,		0.01,		5000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		2,		0.01,		20000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		3,		0.01,		1500,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		7,		0.01,		35000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		8,		0.01,		500000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		9,		0.01,		25000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		10,		0.01,		1500,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		11,		0.01,		500000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		12,		0.01,		50000,		NULL,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		13,		0.01,		1500,		NULL,		 dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 139,		1,		4,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		7,		0.01,		35000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		2,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		1,		13,		0.01,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		4,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		7,		0.01,		20000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		2,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 139,		2,		13,		0.01,		25000,		0,		 dbo.f_Getdatetime2()
GO