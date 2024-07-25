/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240619
	Task: initial data into Company Bet Limit for FastSpin  [Redmine:#205741] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
	  SELECT 230,	1,		1,		0.1,	10000,		NULL
UNION SELECT 230,	1,		2,		0.1,	35000,		NULL
UNION SELECT 230,	1,		3,		0.1,	2500,		NULL
UNION SELECT 230,	1,		5,		0.1,	7500,		NULL
UNION SELECT 230,	1,		4,		0.1,	10000,		NULL
UNION SELECT 230,	1,		8,		0.1,	700000,		NULL
UNION SELECT 230,	1,		10,		0.1,	1000,		NULL
UNION SELECT 230,	1,		7,		0.1,	75000,		NULL
UNION SELECT 230,	1,		9,		0.1,	50000,		NULL
UNION SELECT 230,	1,		11,		0.1,	2500,		NULL
UNION SELECT 230,	1,		12,		0.1,	100000,		NULL
UNION SELECT 230,	2,		1,		0.01,	25000,		NULL
UNION SELECT 230,	2,		2,		0.01,	250000,		NULL
UNION SELECT 230,	2,		3,		0.01,	25000,		NULL
UNION SELECT 230,	2,		5,		0.01,	250000,		NULL
UNION SELECT 230,	2,		4,		0.01,	25000,		NULL
UNION SELECT 230,	2,		8,		0.01,	50000000,	NULL
UNION SELECT 230,	2,		10,		0.01,	25000,		NULL
UNION SELECT 230,	2,		7,		0.01,	500000,		NULL
UNION SELECT 230,	2,		9,		0.01,	100000,		NULL
UNION SELECT 230,	2,		11,		0.01,	1250000,	NULL
UNION SELECT 230,	2,		12,		0.1,	25000,		NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 230,	1,		5,		0.01,	8000,		0
UNION SELECT 230,	1,		4,		0.01,	1000,		0
UNION SELECT 230,	1,		7,		0.01,	15000,		0
UNION SELECT 230,	1,		15,		0.01,	85000,		0
UNION SELECT 230,	1,		8,		0.01,	150000,		0
UNION SELECT 230,	1,		17,		0.01,	4000,		0
UNION SELECT 230,	1,		10,		0.01,	1000000,	0
UNION SELECT 230,	1,		16,		0.01,	2000,		0
UNION SELECT 230,	1,		1,		0.01,	5000,		0
UNION SELECT 230,	1,		14,		0.01,	100000,		0
UNION SELECT 230,	1,		3,		0.01,	35000,		0
UNION SELECT 230,	1,		2,		0.01,	1000,		0
UNION SELECT 230,	1,		13,		0.01,	25000,		0
UNION SELECT 230,	2,		5,		0.01,	250000,		0
UNION SELECT 230,	2,		4,		0.01,	25000,		0
UNION SELECT 230,	2,		7,		0.01,	250000,		0
UNION SELECT 230,	2,		15,		0.01,	500000,		0
UNION SELECT 230,	2,		8,		0.01,	500000,		0
UNION SELECT 230,	2,		17,		0.01,	1250000,	0
UNION SELECT 230,	2,		10,		0.01,	50000000,	0
UNION SELECT 230,	2,		16,		0.01,	25000,		0
UNION SELECT 230,	2,		1,		0.01,	25000,		0
UNION SELECT 230,	2,		14,		0.01,	500000,		0
UNION SELECT 230,	2,		3,		0.01,	500000,		0
UNION SELECT 230,	2,		2,		0.01,	25000,		0
UNION SELECT 230,	2,		13,		0.01,	1250000,	0
GO