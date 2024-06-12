/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240611@Elodie
	Task: Initial ProductStakeLevelGroup - EUR Currency [#206392] 
		https://nexdev.net/issues/206392
	DB: DBCust/CustDB
*/

USE CustDB
GO 
-- Add New Setting StakeLevel for Advanplay (172) - EUR
INSERT INTO ProductStakeLevelGroup 
(
	Sporttype
	, GameGroupID
	, MinBet
	, MaxBet
	, CreditGroupID
	, Remark
	, RepUpdateTime
	, isDeleted
)
SELECT 172
	, 1
	, 0.1
	, 2500
	, 13
	, NULL
	, SYSDATETIME ()
	, 0


	SELECT * FROM ProductStakeLevelGroup where Sporttype = 172 and CreditGroupID = 13