/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20241024@Virgil
	Task: Playtech - Implement customer setting [RedmineID: #210552]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 148, 1, 11, 0.01, 25000000, NULL, SYSDATETIME()
UNION SELECT 148, 2, 11, 0.01, 10000000, NULL, SYSDATETIME()

GO

