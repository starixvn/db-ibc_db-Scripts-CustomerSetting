/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20240919@Virgil
	Task: Playtech - Implement customer setting [RedmineID: #210552]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 148, 1, 1,  0.01, 10000, NULL, SYSDATETIME()
UNION SELECT 148, 1, 5,  0.01, 8000, NULL, SYSDATETIME()
UNION SELECT 148, 1, 7,  0.01, 80000, NULL, SYSDATETIME()
UNION SELECT 148, 1, 8,  0.01, 1500000, NULL, SYSDATETIME()
UNION SELECT 148, 1, 3,  0.01, 2500, NULL, SYSDATETIME()
UNION SELECT 148, 2, 1,  0.01, 5000, NULL, SYSDATETIME()
UNION SELECT 148, 2, 5,  0.01, 4000, NULL, SYSDATETIME()
UNION SELECT 148, 2, 8,  0.01, 1000000, NULL, SYSDATETIME()
UNION SELECT 148, 2, 7,  0.01, 40000, NULL, SYSDATETIME()
UNION SELECT 148, 2, 3,  0.01, 1500, NULL, SYSDATETIME()

GO

----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 148, 1, 1,  0.01, 10000, 0, SYSDATETIME()
UNION SELECT 148, 1, 3,  0.01, 80000, 0, SYSDATETIME()
UNION SELECT 148, 1, 5,  0.01, 8000, 0, SYSDATETIME()
UNION SELECT 148, 1, 8,  0.01, 150000, 0, SYSDATETIME()
UNION SELECT 148, 1, 10, 0.01, 1500000, 0, SYSDATETIME()
UNION SELECT 148, 1, 2,  0.01, 2500, 0, SYSDATETIME()
UNION SELECT 148, 2, 1,  0.01, 5000, 0, SYSDATETIME()
UNION SELECT 148, 2, 3,  0.01, 40000, 0, SYSDATETIME()
UNION SELECT 148, 2, 5,  0.01, 4000, 0, SYSDATETIME()
UNION SELECT 148, 2, 8,  0.01, 80000, 0, SYSDATETIME()
UNION SELECT 148, 2, 10, 0.01, 1000000, 0, SYSDATETIME()
UNION SELECT 148, 2, 2,  0.01, 1500, 0, SYSDATETIME()

GO
