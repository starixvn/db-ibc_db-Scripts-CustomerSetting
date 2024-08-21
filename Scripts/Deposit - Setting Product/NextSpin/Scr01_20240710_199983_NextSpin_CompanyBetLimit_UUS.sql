/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240710
	Task: Nextspin - initial data into Company Bet Limit - UUS  [Redmine:#199983] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
	  SELECT 229,	1,	6,	0.01,	2500,	NULL
UNION SELECT 229,	2,	6,	0.01,	500,	NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 229,	1,	6,	0.01,	1000,	0
UNION SELECT 229,	2,	6,	0.01,	500,	0
GO