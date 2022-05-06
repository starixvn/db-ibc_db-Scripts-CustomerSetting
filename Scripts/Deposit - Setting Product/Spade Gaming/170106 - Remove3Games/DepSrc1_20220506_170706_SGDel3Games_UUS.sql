/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220506@Winfred
	Created: Winfred 
	Task: Spadegaming - Remove 3 games 4326 - 4385 - 4386 - UUS Deposit [Redmine:#170706]
	DB: DBCUST/CUSTDB
*/

DELETE a
FROM Dep_StakeLevelGroupDetail a  WITH(ROWLOCK)
INNER JOIN Dep_StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 4301 AND b.ExchangeID IN (20,72) AND a.GameTypeID IN (4326,4385,4386)