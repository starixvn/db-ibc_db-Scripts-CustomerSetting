/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220401@Winfred
	Created: Winfred 
	Task: Pragmatic - Remove 2 new games 4070 - 4097 [Redmine:#170383]
	DB: DBCUST/CUSTDB
*/

DELETE a
FROM StakeLevelGroupDetail a  WITH(ROWLOCK)
INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 4001 AND a.GameTypeID IN (4070,4097)


DELETE a
FROM Dep_StakeLevelGroupDetail a  WITH(ROWLOCK)
INNER JOIN Dep_StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 4001 AND a.GameTypeID IN (4070,4097)