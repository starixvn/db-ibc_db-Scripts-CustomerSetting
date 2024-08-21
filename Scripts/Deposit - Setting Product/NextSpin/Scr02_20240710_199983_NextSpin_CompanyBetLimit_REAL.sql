/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240710
	Task: Nextspin - initial data into Company Bet Limit  [Redmine:#199983] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
	  SELECT 229,	1,		1,		0.01,	10000,		NULL
UNION SELECT 229,	1,		2,		0.01,	35000,		NULL
UNION SELECT 229,	1,		3,		0.01,	2500,		NULL
UNION SELECT 229,	1,		5,		0.01,	7500,		NULL
UNION SELECT 229,	1,		4,		0.01,	10000,		NULL
UNION SELECT 229,	1,		8,		0.01,	700000,		NULL
UNION SELECT 229,	1,		10,		0.01,	2000,		NULL
UNION SELECT 229,	1,		7,		0.01,	75000,		NULL
UNION SELECT 229,	1,		11,		0.01,	2500000,	NULL
UNION SELECT 229,	1,		12,		0.01,	100000,		NULL
UNION SELECT 229,	1,		14,		0.01,	2500,		NULL
UNION SELECT 229,	1,		16,		0.01,	150000,		NULL
UNION SELECT 229,	2,		1,		0.01,	2500,		NULL
UNION SELECT 229,	2,		2,		0.01,	8000,		NULL
UNION SELECT 229,	2,		3,		0.01,	500,		NULL
UNION SELECT 229,	2,		5,		0.01,	2000,		NULL
UNION SELECT 229,	2,		4,		0.01,	2500,		NULL
UNION SELECT 229,	2,		8,		0.01,	350000,		NULL
UNION SELECT 229,	2,		10,		0.01,	500,		NULL
UNION SELECT 229,	2,		7,		0.01,	20000,		NULL
UNION SELECT 229,	2,		11,		0.01,	500000,		NULL
UNION SELECT 229,	2,		12,		0.01,	25000,		NULL
UNION SELECT 229,	2,		14,		0.01,	500,		NULL
UNION SELECT 229,	2,		16,		0.01,	50000,		NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 229,	1,		5,		0.01,	8000,		0
UNION SELECT 229,	1,		4,		0.01,	1000,		0
UNION SELECT 229,	1,		7,		0.01,	15000,		0
UNION SELECT 229,	1,		15,		0.01,	85000,		0
UNION SELECT 229,	1,		8,		0.01,	150000,		0
UNION SELECT 229,	1,		10,		0.01,	1000000,	0
UNION SELECT 229,	1,		1,		0.01,	5000,		0
UNION SELECT 229,	1,		3,		0.01,	35000,		0
UNION SELECT 229,	1,		2,		0.01,	1000,		0
UNION SELECT 229,	1,		13,		0.01,	25000,		0
UNION SELECT 229,	2,		5,		0.01,	4000,		0
UNION SELECT 229,	2,		4,		0.01,	500,		0
UNION SELECT 229,	2,		7,		0.01,	7500,		0
UNION SELECT 229,	2,		15,		0.01,	42500,		0
UNION SELECT 229,	2,		8,		0.01,	75000,		0
UNION SELECT 229,	2,		10,		0.01,	500000,		0
UNION SELECT 229,	2,		1,		0.01,	2500,		0
UNION SELECT 229,	2,		3,		0.01,	17500,		0
UNION SELECT 229,	2,		2,		0.01,	500,		0
UNION SELECT 229,	2,		13,		0.01,	12500,		0
GO