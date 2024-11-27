/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240729
	Task: initial data into Company Bet Limit for GPI  [Redmine:#207175] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 145,	1,		1,		0.01,	10000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		2,		0.01,	35000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		3,		0.01,	2500,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		5,		0.01,	7500,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		4,		0.01,	10000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		8,		0.01,	700000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		10,		0.01,	2000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		7,		0.01,	75000,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		11,		0.01,	2500000,	NULL,	SYSDATETIME()
UNION SELECT 145,	1,		13,		0.01,	2500,		NULL,	SYSDATETIME()
UNION SELECT 145,	1,		14,		0.01,	2500,		NULL,	SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 145,	1,		20,		0.01,	100000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		11,		0.01,	1000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		18,		0.01,	5000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		5,		0.01,	8000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		19,		0.01,	700000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		4,		0.01,	1000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		7,		0.01,	15000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		15,		0.01,	85000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		8,		0.01,	150000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		17,		0.01,	4000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		10,		0.01,	1000000,	0,	SYSDATETIME()
UNION SELECT 145,	1,		16,		0.01,	2000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		12,		0.01,	15000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		1,		0.01,	5000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		22,		0.01,	100000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		9,		0.01,	50000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		21,		0.01,	200000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		14,		0.01,	100000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		3,		0.01,	35000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		2,		0.01,	1000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		13,		0.01,	25000,		0,	SYSDATETIME()
UNION SELECT 145,	1,		23,		0.01,	500000,		0,	SYSDATETIME()
GO