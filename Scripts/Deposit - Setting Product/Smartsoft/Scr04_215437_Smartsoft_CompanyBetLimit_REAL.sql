/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: 20241218@Virgil
	Task: Smartsoft - Implement Customer Setting and Initial data [RedmineID: #210946]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 135,	1,		1,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		2,		0.01,	35000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		3,		0.01,	2500,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		4,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		5,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		7,		0.01,	75000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		8,		0.01,	1000000,	NULL, SYSDATETIME()
UNION SELECT 135,	1,		9,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		10,		0.01,	3000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		11,		0.01,	2500000,	NULL, SYSDATETIME()
UNION SELECT 135,	1,		12,		0.01,	100000,		NULL, SYSDATETIME()
UNION SELECT 135,	1,		13,		0.01,	2500,		NULL, SYSDATETIME()

UNION SELECT 135,	2,		1,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		2,		0.01,	20000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		3,		0.01,	1500,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		4,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		5,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		7,		0.01,	30000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		8,		0.01,	500000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		9,		0.01,	25000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		10,		0.01,	1500,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		11,		0.01,	1250000,	NULL, SYSDATETIME()
UNION SELECT 135,	2,		12,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 135,	2,		13,		0.01,	1500,		NULL, SYSDATETIME()

GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	 SELECT 135,	1,		2,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 135,	1,		4,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 135,	1,		5,		0.01,	10000,		0, SYSDATETIME()
UNION SELECT 135,	1,		7,		0.01,	35000,		0, SYSDATETIME()
UNION SELECT 135,	1,		13,		0.01,	50000,		0, SYSDATETIME()

UNION SELECT 135,	2,		2,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 135,	2,		4,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 135,	2,		5,		0.01,	5000,		0, SYSDATETIME()
UNION SELECT 135,	2,		7,		0.01,	20000,		0, SYSDATETIME()
UNION SELECT 135,	2,		13,		0.01,	25000,		0, SYSDATETIME()

GO
