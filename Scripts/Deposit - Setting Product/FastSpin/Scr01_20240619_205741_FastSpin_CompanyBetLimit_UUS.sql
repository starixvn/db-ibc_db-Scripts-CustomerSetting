/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240619
	Task: initial data into Company Bet Limit for FastSpin - UUS  [Redmine:#205741] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
 	  SELECT 230,	1,		6,		0.1,	10000,		NULL
UNION SELECT 230,	2,		6,		0.01,	25000,		NULL
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 230,	1,		6,		0.01,	5000,		0
UNION SELECT 230,	2,		6,		0.01,	25000,		0
GO