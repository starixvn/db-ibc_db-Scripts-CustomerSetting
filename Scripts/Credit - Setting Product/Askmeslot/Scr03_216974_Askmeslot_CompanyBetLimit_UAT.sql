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
	SELECT	130,	1,		1,		0.01,	10000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		3,		0.01,	2500,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		2,		0.01,	35000,		NULL, SYSDATETIME()
UNION SELECT 130,	1,		7,		0.01,	75000,		NULL, SYSDATETIME()

GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	SELECT 130,		1,		2,		0.01,	2500,		0, SYSDATETIME()
UNION SELECT 130,	1,		7,		0.01,	35000,		0, SYSDATETIME()

GO
