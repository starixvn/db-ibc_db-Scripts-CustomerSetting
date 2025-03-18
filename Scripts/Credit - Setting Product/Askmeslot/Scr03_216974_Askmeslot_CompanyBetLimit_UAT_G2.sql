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
	SELECT 130,	2,		1,		0.01,	5000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		2,		0.01,	20000,		NULL, SYSDATETIME()
UNION SELECT 130,	2,		3,		0.01,	1500,		'Do not offer fishing games due to the min bet being 0.002', SYSDATETIME()
UNION SELECT 130,	2,		7,		0.01,	30000,		NULL, SYSDATETIME()

GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	SELECT 130,	2,		2,		0.01,	1500,		0, SYSDATETIME()
UNION SELECT 130,	2,		7,		0.01,	20000,		0, SYSDATETIME()

GO