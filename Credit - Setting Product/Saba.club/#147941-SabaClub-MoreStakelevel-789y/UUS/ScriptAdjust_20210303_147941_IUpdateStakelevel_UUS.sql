/*
	Created: Eden@20210303
	Task: update StakeLevel, StakeLevelGroupDetail for Saba.Club - UUS [#147941]
	DB: DBCust/CustDB
*/
USE CUSTDB
GO

--> Update change GameGroupID
UPDATE s
SET GameGroupID = CASE WHEN s.GameGroupID = 13 then 20 ELSE 13 END
FROM StakeLevel s WITH(ROWLOCK) 
	INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) ON s.StakeLevelID = g.StakeLevelID AND g.GameTypeID = 1611
WHERE s.ExchangeId = 20

--> Update change Stake
UPDATE g
SET g.MaxLabel = CASE WHEN s.GameGroupID = 13 THEN '3,000' ELSE '50,000' END,
	g.MaxStake = CASE WHEN s.GameGroupID = 13 THEN 3000 ELSE 50000 END
FROM StakeLevel s WITH(NOLOCK) 
	INNER JOIN StakeLevelGroupDetail g WITH(ROWLOCK) ON s.StakeLevelID = g.StakeLevelID AND g.GameTypeID = 1611
WHERE s.ExchangeId = 20