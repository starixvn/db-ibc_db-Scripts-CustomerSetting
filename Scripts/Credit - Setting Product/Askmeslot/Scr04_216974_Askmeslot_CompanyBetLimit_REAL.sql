/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20250204@Dave
	Task: Askmeslot - Implement Customer Setting and initial data [RedmineID: #216977]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	SELECT 130,	1,		4,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		5,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		8,		0.01,	1000000,	NULL, SYSDATETIME()
UNION SELECT 130,	1,		9,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		10,		0.01,	3000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		12,		0.01,	100000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		13,		0.01,	2500,		NULL, SYSDATETIME()


UNION SELECT 130,	2,		4,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		5,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		8,		0.01,	500000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		9,		0.01,	25000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		10,		0.01,	1500,		'Do not offer fishing games due to the min bet being 0.009', SYSDATETIME()
UNION SELECT 130,	2,		12,		0.01,	50000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		13,		0.01,	1500,		NULL, SYSDATETIME()

GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	SELECT 130,	1,		4,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 130,	1,		13,		0.01,	50000,		0, SYSDATETIME()

UNION SELECT 130,	2,		4,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 130,	2,		13,		0.01,	25000,		0, SYSDATETIME()

GO