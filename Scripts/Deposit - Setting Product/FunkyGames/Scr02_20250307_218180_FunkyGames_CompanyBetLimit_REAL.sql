/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250307
	Task: initial data into Company Bet Limit for Funky Games  [Redmine:#218180] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 131,	1,	1,		0.01,	2500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	2,		0.01,	8000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	3,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	5,		0.01,	2000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	4,		0.01,	2500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	8,		0.01,	350000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	10,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	7,		0.01,	20000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	9,		0.01,	6500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	11,		0.01,	500000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	12,		0.01,	25000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	13,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	1,		0.01,	2500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	2,		0.01,	8000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	3,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	5,		0.01,	2000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	4,		0.01,	2500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	8,		0.01,	350000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	10,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	7,		0.01,	20000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	9,		0.01,	6500,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	11,		0.01,	500000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	12,		0.01,	25000,	NULL,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	13,		0.01,	500,	NULL,	 dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 131,	1,	4,		0.01,	500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	7,		0.01,	8000,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	5,		0.01,	2000,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	2,		0.01,	500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	1,	13,		0.01,	6500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	4,		0.01,	500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	7,		0.01,	8000,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	5,		0.01,	2000,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	2,		0.01,	500,	0,	 dbo.f_Getdatetime2()
UNION SELECT 131,	2,	13,		0.01,	6500,	0,	 dbo.f_Getdatetime2()
GO