/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: PLAY STAR - Implement setting and initial data [RedmineID: #208021]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 143,	1,		1,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		2,		0.01,	35000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		3,		0.01,	2500,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		4,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		5,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		7,		0.01,	75000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		8,		0.01,	1000000,	NULL, SYSDATETIME()
UNION SELECT 143,	1,		9,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		10,		0.01,	3000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		11,		0.01,	2500000,	NULL, SYSDATETIME()
UNION SELECT 143,	1,		12,		0.01,	100000,		NULL, SYSDATETIME()
UNION SELECT 143,	1,		13,		0.01,	2500,		NULL, SYSDATETIME()

UNION SELECT 143,	2,		1,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		2,		0.01,	20000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		3,		0.01,	1500,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		4,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		5,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		7,		0.01,	30000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		8,		0.01,	500000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		9,		0.01,	25000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		10,		0.01,	1500,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		11,		0.01,	1250000,	NULL, SYSDATETIME()
UNION SELECT 143,	2,		12,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 143,	2,		13,		0.01,	1500,		NULL, SYSDATETIME()

GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	 SELECT 143,	1,		2,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 143,	1,		4,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 143,	1,		7,		0.01,	35000,		0, SYSDATETIME()
UNION SELECT 143,	1,		13,		0.01,	50000,		0, SYSDATETIME()

UNION SELECT 143,	2,		2,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 143,	2,		4,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 143,	2,		7,		0.01,	20000,		0, SYSDATETIME()
UNION SELECT 143,	2,		13,		0.01,	25000,		0, SYSDATETIME()

GO
