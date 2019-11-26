 /*
	Created: Winnie
	Date: 20191126
	Task: Macau Games - Support to update Bet Limit for "Stud Poker" & "Roulette"
	Redmine: https://nexdev.net/issues/124459
	DB: DBCUST/CustDB
 */
 
UPDATE D
SET MinStake=5,MaxStake=2500,MinLabel='5',MaxLabel='2500'
FROM StakeLevelGroupDetail d WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel SK WITH (NOLOCK) ON d.StakeLevelID = sk.StakeLevelID and sk.GameGroupID = 1	
WHERE SK.GameTypeID = 4001 AND d.GameTypeID = 4022 AND sk.ExchangeId=67

UPDATE D
SET MinStake=5,MaxStake=1000,MinLabel='5',MaxLabel='1000'
FROM StakeLevelGroupDetail d WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel SK WITH (NOLOCK) ON d.StakeLevelID = sk.StakeLevelID and sk.GameGroupID = 1
WHERE SK.GameTypeID = 4001 AND d.GameTypeID = 4004 AND sk.ExchangeId=67
