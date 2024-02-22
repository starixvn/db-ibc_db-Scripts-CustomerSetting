/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231201
	Task: initial data for ProductStakeLevelGroup & Dep_ProductStakeLevelGroup - Real Currency [Redmine:#194531] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet)
	  SELECT 227,	1,	1,	0.01,	5000
UNION SELECT 227,	1,	2,	0.01,	17500
UNION SELECT 227,	1,	3,	0.01,	1250
UNION SELECT 227,	1,	5,	0.01,	3750
UNION SELECT 227,	1,	4,	0.01,	5000
UNION SELECT 227,	1,	8,	0.01,	350000
UNION SELECT 227,	1,	10,	0.01,	1000
UNION SELECT 227,	1,	7,	0.01,	37500
UNION SELECT 227,	1,	12,	0.01,	50000
GO
		
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)	 
	  SELECT 227,	1,	5,	0.01,	4000,	0
UNION SELECT 227,	1,	4,	0.01,	500,	0
UNION SELECT 227,	1,	7,	0.01,	7500,	0
UNION SELECT 227,	1,	15,	0.01,	42500,	0
UNION SELECT 227,	1,	8,	0.01,	75000,	0
UNION SELECT 227,	1,	10,	0.01,	500000,	0
UNION SELECT 227,	1,	16,	0.01,	2000,	0
UNION SELECT 227,	1,	1,	0.01,	2500,	0
UNION SELECT 227,	1,	14,	0.01,	50000,	0
UNION SELECT 227,	1,	3,	0.01,	17500,	0
UNION SELECT 227,	1,	2,	0.01,	500,	0
UNION SELECT 227,	1,	13,	0.01,	12500,	0
GO