/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250520
	Task: initial data into Company Bet Limit for ClotPlay [Redmine: #228003] 
	DB:	DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, RepUpdateTime)
	  SELECT 122,		1,		1,		0.01,		10000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		2,		0.01,		35000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		3,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		4,		0.01,		10000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		5,		0.01,		10000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		6,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		7,		0.01,		75000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		8,		0.01,		1000000,	dbo.f_Getdatetime2()
UNION SELECT 122,		1,		9,		0.01,		50000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		11,		0.01,		2500000,	dbo.f_Getdatetime2()
UNION SELECT 122,		1,		12,		0.01,		100000,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		13,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 122,		1,		10,		0.01,		3000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		1,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		2,		0.01,		20000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		3,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		4,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		5,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		6,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		7,		0.01,		35000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		8,		0.01,		500000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		9,		0.01,		25000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		11,		0.01,		1000000,	dbo.f_Getdatetime2()
UNION SELECT 122,		2,		12,		0.01,		50000,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		13,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 122,		2,		10,		0.01,		1500,		dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 122,		1,		2,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		1,		4,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		1,		7,		0.01,		35000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		1,		13,		0.01,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		1,		6,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		2,		2,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		2,		4,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		2,		7,		0.01,		20000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		2,		13,		0.01,		25000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 122,		2,		6,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
GO
