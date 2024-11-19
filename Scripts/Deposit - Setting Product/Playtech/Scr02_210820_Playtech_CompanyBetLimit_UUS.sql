/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20240919@Virgil
	Task: Playtech - Implement customer setting [RedmineID: #210552]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 148,	1,	6,	0.01,	2500,	NULL, SYSDATETIME()
UNION SELECT 148,	2,	6,	0.01,	1500,	NULL, SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, RepUpdateTime, SiteID)
	  SELECT 148,	1,	6,	0.01,	2500, SYSDATETIME() , 0
UNION SELECT 148,	2,	6,	0.01,	1500, SYSDATETIME() , 0
GO
