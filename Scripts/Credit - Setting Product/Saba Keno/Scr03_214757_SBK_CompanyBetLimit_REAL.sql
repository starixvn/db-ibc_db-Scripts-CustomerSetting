/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241213@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
SELECT 133,	2,	3,	0.1,	2000,	'Offer 789y only', SYSDATETIME()

GO

