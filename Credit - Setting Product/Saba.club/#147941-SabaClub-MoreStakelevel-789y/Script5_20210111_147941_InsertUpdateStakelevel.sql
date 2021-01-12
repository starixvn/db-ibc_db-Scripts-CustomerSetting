/*
	Created: Eden@20210111
	Task: insert update StakeLevel, StakeLevelGroupDetail for Saba.Club [#147941]
	DB: DBCust/CustDB
*/
USE CUSTDB
GO

DECLARE @StakeLevel TABLE
(
	GameTypeID  INT,
	ExchangeId  INT, 
	GameGroupID INT
);

INSERT INTO @StakeLevel(ExchangeId)
SELECT 3
UNION ALL SELECT 16
UNION ALL SELECT 17
UNION ALL SELECT 35
UNION ALL SELECT 36
UNION ALL SELECT 40
UNION ALL SELECT 64
UNION ALL SELECT 65
UNION ALL SELECT 68
UNION ALL SELECT 74

UPDATE @StakeLevel 
SET GameTypeID = 1611,
	GameGroupID = 13

--Update New game Group ( change from level 1 to level 2 ) for current stake level 
UPDATE s 
SET s.GameGroupID = 20
FROM StakeLevel s WITH(NOLOCK) 
	INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) ON s.StakeLevelID = g.StakeLevelID AND g.GameTypeID = 1611
WHERE GameGroupID = 13
	AND s.ExchangeId IN( SELECT ExchangeId FROM @StakeLevel)
	AND g.MinStake = 0.01 AND g.MaxStake = 5000

--Insert StakeLevel level 1
INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT t.GameTypeID,t.ExchangeId,t.GameGroupID 
FROM @StakeLevel t
	LEFT JOIN StakeLevel s WITH(NOLOCK) 
		ON t.ExchangeId = s.ExchangeId 
		AND t.GameGroupID = s.GameGroupID 
		AND t.GameTypeID = s.GameTypeID
WHERE s.GameTypeID IS NULL

--Insert StakeLevelGroupDetail level 1
INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT s.StakeLevelID, s.GameTypeID, '0.01', '3,000', 0.01, 3000
FROM dbo.StakeLevel s WITH (NOLOCK)
	LEFT JOIN StakeLevelGroupDetail g WITH(NOLOCK) On s.StakeLevelID = g.StakeLevelID
WHERE s.GameTypeID = 1611 
	AND s.GameGroupID = 13
	AND s.ExchangeId IN(SELECT ExchangeId FROM @StakeLevel)
	AND g.StakeLevelID IS NULL

