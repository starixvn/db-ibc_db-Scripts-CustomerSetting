/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial StakeLevel - Real Currency [#198960]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

UPDATE sl
	SET 
		sl.MinLabel = '100'
	,	sl.MaxLabel = '10,000'
	,	sl.MinStake = 100
	,	sl.MaxStake = 10000
FROM StakeLevel sl WITH (ROWLOCK , UPDLOCK)
WHERE sl.StakeLevelID = 6270
AND sl.GameTypeID = 8201
AND sl.ExchangeId = 14