/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240813
	Task: initial data into Dep_ProductStakeLevelGroup for VGaming - Slot Games  [Redmine:#205654] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
--VGaming - Slot games
	  SELECT 171,	1,	23,	0.01,	500000,		0
UNION SELECT 171,	1,	20,	0.01,	100000,		0
UNION SELECT 171,	1,	11,	0.01,	1500,		0
UNION SELECT 171,	1,	18,	0.01,	5000,		0
UNION SELECT 171,	1,	25,	0.01,	1000,		0
UNION SELECT 171,	1,	32,	0.01,	500000,		0
UNION SELECT 171,	1,	5,	0.01,	8000,		0
UNION SELECT 171,	1,	19,	0.01,	4000000,	0
UNION SELECT 171,	1,	4,	0.01,	1000,		0
UNION SELECT 171,	1,	24,	0.01,	500,		0
UNION SELECT 171,	1,	31,	0.01,	10000,		0
UNION SELECT 171,	1,	7,	0.01,	15000,		0
UNION SELECT 171,	1,	15,	0.01,	85000,		0
UNION SELECT 171,	1,	8,	0.01,	150000,		0
UNION SELECT 171,	1,	30,	0.01,	50000,		0
UNION SELECT 171,	1,	17,	0.01,	4000,		0
UNION SELECT 171,	1,	10,	0.01,	1000000,	0
UNION SELECT 171,	1,	16,	0.01,	2000,		0
UNION SELECT 171,	1,	12,	0.01,	15000,		0
UNION SELECT 171,	1,	1,	0.01,	5000,		0
UNION SELECT 171,	1,	27,	0.01,	5000,		0
UNION SELECT 171,	1,	22,	0.01,	100000,		0
UNION SELECT 171,	1,	33,	0.01,	2000,		0
UNION SELECT 171,	1,	21,	0.01,	300000,		0
UNION SELECT 171,	1,	28,	0.01,	2000,		0
UNION SELECT 171,	1,	14,	0.01,	100000,		0
UNION SELECT 171,	1,	26,	0.01,	5000,		0
UNION SELECT 171,	1,	3,	0.01,	35000,		0
UNION SELECT 171,	1,	3,	1,		2500,		875
UNION SELECT 171,	1,	29,	0.01,	15000,		0
UNION SELECT 171,	1,	2,	0.01,	1000,		0
UNION SELECT 171,	1,	6,	0.01,	1000,		0
UNION SELECT 171,	1,	6,	1,		2500,		875
UNION SELECT 171,	1,	13,	0.01,	25000,		0
UNION SELECT 171,	1,	34,	0.1,	60000,		0
GO