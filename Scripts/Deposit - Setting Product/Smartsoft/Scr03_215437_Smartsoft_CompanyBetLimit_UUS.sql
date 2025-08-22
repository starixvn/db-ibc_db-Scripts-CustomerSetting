/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: Smartsoft - Implement Customer Setting and Initial data [RedmineID: #210946]
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 135,	1,	6,	0.01,	2500,	NULL, SYSDATETIME()
UNION SELECT 135,	2,	6,	0.01,	1500,	NULL, SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, RepUpdateTime, SiteID)
	  SELECT 135,	1,	6,	0.01,	2500, SYSDATETIME() , 0
UNION SELECT 135,	2,	6,	0.01,	1500, SYSDATETIME() , 0
GO
