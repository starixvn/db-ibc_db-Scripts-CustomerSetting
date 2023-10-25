/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231009
	Task: INITIAL sample data for testing - SIT (PP, SG) [Redmine:#194624] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO [ProductStakeLevelGroup]([Sporttype], [GameGroupID], [CreditGroupID], [MinBet], [MaxBet], [Remark])
SELECT 248, 1, 6, 0.1, 2500, NULL
UNION
SELECT 248, 2, 6, 0.1, 500, NULL
UNION
SELECT 247, 1, 6, 0.1, 2500, NULL
UNION
SELECT 247, 2, 6, 0.1, 500, NULL