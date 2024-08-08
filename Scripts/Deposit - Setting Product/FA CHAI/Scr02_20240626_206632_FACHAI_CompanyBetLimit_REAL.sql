/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240626
	Task: initial data into Company Bet Limit for FA CHAI  [Redmine:#206632] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
	  SELECT 146,	1,		1,		0.01,	10000,		NULL
UNION SELECT 146,	1,		2,		0.01,	35000,		NULL
UNION SELECT 146,	1,		3,		0.01,	2500,		NULL
UNION SELECT 146,	1,		4,		0.01,	10000,		NULL
UNION SELECT 146,	1,		5,		0.01,	7500,		NULL
UNION SELECT 146,	1,		7,		0.01,	75000,		NULL
UNION SELECT 146,	1,		8,		0.01,	700000,		NULL
UNION SELECT 146,	1,		9,		0.01,	50000,		NULL
UNION SELECT 146,	1,		10,		0.01,	2000,		NULL
UNION SELECT 146,	1,		11,		0.01,	2500000,	NULL
UNION SELECT 146,	1,		12,		0.01,	100000,		NULL
UNION SELECT 146,	1,		13,		0.01,	2500,		NULL
UNION SELECT 146,	1,		14,		0.01,	2500,		NULL
UNION SELECT 146,	2,		1,		0.01,	2500,		NULL
UNION SELECT 146,	2,		2,		0.01,	8000,		NULL
UNION SELECT 146,	2,		3,		0.01,	500,		NULL
UNION SELECT 146,	2,		4,		0.01,	2500,		NULL
UNION SELECT 146,	2,		5,		0.01,	2000,		NULL
UNION SELECT 146,	2,		7,		0.01,	20000,		NULL
UNION SELECT 146,	2,		8,		0.01,	350000,		NULL
UNION SELECT 146,	2,		9,		0.01,	6500,		NULL
UNION SELECT 146,	2,		10,		0.01,	500,		NULL
UNION SELECT 146,	2,		11,		0.01,	500000,		NULL
UNION SELECT 146,	2,		12,		0.01,	25000,		NULL
UNION SELECT 146,	2,		13,		0.01,	500,		NULL
UNION SELECT 146,	2,		14,		0.01,	500,		NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 146,	1,		1,		0.01,	5000,		0
UNION SELECT 146,	1,		2,		0.01,	1000,		0
UNION SELECT 146,	1,		3,		0.01,	35000,		0
UNION SELECT 146,	1,		4,		0.01,	1000,		0
UNION SELECT 146,	1,		5,		0.01,	8000,		0
UNION SELECT 146,	1,		7,		0.01,	15000,		0
UNION SELECT 146,	1,		8,		0.01,	150000,		0
UNION SELECT 146,	1,		9,		0.01,	50000,		0
UNION SELECT 146,	1,		10,		0.01,	1000000,	0
UNION SELECT 146,	1,		11,		0.01,	1000,		0
UNION SELECT 146,	1,		12,		0.01,	20000,		0
UNION SELECT 146,	1,		13,		0.01,	25000,		0
UNION SELECT 146,	1,		14,		0.01,	100000,		0
UNION SELECT 146,	1,		15,		0.01,	85000,		0
UNION SELECT 146,	1,		16,		0.01,	2500,		0
UNION SELECT 146,	1,		17,		0.01,	5000,		0
UNION SELECT 146,	1,		18,		0.01,	5000,		0
UNION SELECT 146,	1,		19,		0.01,	700000,		0
UNION SELECT 146,	1,		20,		0.01,	100000,		0
UNION SELECT 146,	1,		21,		0.01,	200000,		0
UNION SELECT 146,	1,		22,		0.01,	100000,		0
UNION SELECT 146,	1,		23,		0.01,	500000,		0
UNION SELECT 146,	2,		1,		0.01,	2500,		0
UNION SELECT 146,	2,		2,		0.01,	500,		0
UNION SELECT 146,	2,		3,		0.01,	17500,		0
UNION SELECT 146,	2,		4,		0.01,	500,		0
UNION SELECT 146,	2,		5,		0.01,	4000,		0
UNION SELECT 146,	2,		7,		0.01,	7500,		0
UNION SELECT 146,	2,		8,		0.01,	75000,		0
UNION SELECT 146,	2,		9,		0.01,	25000,		0
UNION SELECT 146,	2,		10,		0.01,	500000,		0
UNION SELECT 146,	2,		11,		0.01,	500,		0
UNION SELECT 146,	2,		12,		0.01,	10000,		0
UNION SELECT 146,	2,		13,		0.01,	12500,		0
UNION SELECT 146,	2,		14,		0.01,	50000,		0
UNION SELECT 146,	2,		15,		0.01,	42500,		0
UNION SELECT 146,	2,		16,		0.01,	1000,		0
UNION SELECT 146,	2,		17,		0.01,	2000,		0
UNION SELECT 146,	2,		18,		0.01,	2000,		0
UNION SELECT 146,	2,		19,		0.01,	500000,		0
UNION SELECT 146,	2,		20,		0.01,	50000,		0
UNION SELECT 146,	2,		21,		0.01,	100000,		0
UNION SELECT 146,	2,		22,		0.01,	50000,		0
UNION SELECT 146,	2,		23,		0.01,	300000,		0
GO