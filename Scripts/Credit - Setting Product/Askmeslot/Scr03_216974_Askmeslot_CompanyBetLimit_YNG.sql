/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20250204@Dave
	Task: Askmeslot - Implement Customer Setting and initial data [RedmineID: #216977]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
USE CustDB
GO
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	SELECT	130,	1,		11,		0.01,	2500000,	NULL, SYSDATETIME()
UNION SELECT 130,	2,		11,		0.01,	1250000,	NULL, SYSDATETIME()
GO
