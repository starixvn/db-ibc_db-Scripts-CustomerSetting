/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: PLAY STAR - Implement setting and initial data [RedmineID: #208021]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 143,	1,	6,	0.01,	2500,	NULL, SYSDATETIME()
UNION SELECT 143,	2,	6,	0.01,	1500,	NULL, SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, RepUpdateTime, SiteID)
	  SELECT 143,	1,	6,	0.01,	2500, SYSDATETIME() , 0
UNION SELECT 143,	2,	6,	0.01,	1500, SYSDATETIME() , 0
GO
