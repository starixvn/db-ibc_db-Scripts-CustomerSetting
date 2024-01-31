/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240126
	Task: initial data into Dep_ProductStakeLevelGroup [Redmine:#198243] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)	 
	  SELECT 171,	2,	20,	0.01,	100000,		0
UNION SELECT 171,	2,	11,	0.01,	1500,		0
UNION SELECT 171,	2,	18,	0.01,	5000,		0
UNION SELECT 171,	2,	5,	0.01,	8000,		0
UNION SELECT 171,	2,	19,	0.01,	4000000,	0
UNION SELECT 171,	2,	4,	0.01,	1000,		0
UNION SELECT 171,	2,	7,	0.01,	15000,		0
UNION SELECT 171,	2,	15,	0.01,	85000,		0
UNION SELECT 171,	2,	8,	0.01,	150000,		0
UNION SELECT 171,	2,	17,	0.01,	4000,		0
UNION SELECT 171,	2,	10,	0.01,	1000000,	0
UNION SELECT 171,	2,	16,	0.01,	2000,		0
UNION SELECT 171,	2,	12,	0.01,	15000,		0
UNION SELECT 171,	2,	1,	0.01,	5000,		0
UNION SELECT 171,	2,	22,	0.01,	100000,		0
UNION SELECT 171,	2,	21,	0.01,	300000,		0
UNION SELECT 171,	2,	14,	0.01,	100000,		0
UNION SELECT 171,	2,	3,	0.01,	35000,		0
UNION SELECT 171,	2,	3,	1,		2500,		875	--SEAL888
UNION SELECT 171,	2,	2,	0.01,	1000,		0
UNION SELECT 171,	2,	13,	0.01,	25000,		0
UNION SELECT 171,	2,	6,	0.01,	1000,		0
GO