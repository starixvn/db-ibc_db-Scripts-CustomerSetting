/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240925
	Task: Add PG Soft - THB into ProductStakeLevelGroup [Redmine:#211252] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
SELECT 232,		1,		7,		0.1,	75000,	'Add settings on Sep 25', dbo.f_GetDateTime2()
GO