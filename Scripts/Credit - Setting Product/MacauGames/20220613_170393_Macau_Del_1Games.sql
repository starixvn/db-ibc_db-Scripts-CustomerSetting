/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220613@Winfred
	Created: Winfred 
	Task: Pragmatic - Remove new games 5805 [Redmine:#170383]
	DB: DBCUST/CUSTDB
*/

DELETE a
FROM StakeLevelGroupDetail a  WITH(ROWLOCK)
INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 4001 AND b.ExchangeID IN (20) AND a.GameTypeID IN (5805)
