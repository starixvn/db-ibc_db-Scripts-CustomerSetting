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
	  SELECT 130,	1,	6,	0.01,	2500,	NULL, SYSDATETIME()
UNION SELECT 130,	2,	6,	0.01,	1500,	NULL, SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, RepUpdateTime, SiteID)
	  SELECT 130,	1,	6,	0.01,	2500, SYSDATETIME() , 0
UNION SELECT 130,	2,	6,	0.01,	1500, SYSDATETIME() , 0
GO
