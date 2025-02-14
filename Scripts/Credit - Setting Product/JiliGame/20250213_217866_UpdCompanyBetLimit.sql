/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: 20250213@Virgil
	Task: Jili - Update Credit Company Bet Limit [RedmineID: #217862]
	DB: DBCUST-CustDB
*/
DECLARE @SportType SMALLINT = 158;

UPDATE ProductStakeLevelGroup WITH(ROWLOCK, UPDLOCK)
SET MinBet = 0.01,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE Sporttype = @SportType
	AND MinBet = 0.1