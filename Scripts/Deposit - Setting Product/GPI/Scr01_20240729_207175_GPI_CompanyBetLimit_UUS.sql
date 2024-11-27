/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240729
	Task: initial data into Company Bet Limit for GPI - UUS  [Redmine:#207175] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	SELECT 145,	1,	6,	0.01,	2500,	NULL, SYSDATETIME()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	SELECT 145,	1,	6,	0.01,	1000,	0, SYSDATETIME()
GO