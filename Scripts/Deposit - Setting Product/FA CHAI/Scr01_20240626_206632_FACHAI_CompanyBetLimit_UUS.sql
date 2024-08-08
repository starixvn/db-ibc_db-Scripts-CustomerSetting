/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240626
	Task: initial data into Company Bet Limit for FA CHAI - UUS  [Redmine:#206632] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
	  SELECT 146,	1,	6,	0.01,	2500,	NULL
UNION SELECT 146,	2,	6,	0.01,	500,	NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 146,	1,	6,	0.01,	2500,	0
UNION SELECT 146,	2,	6,	0.01,	500,	0
GO