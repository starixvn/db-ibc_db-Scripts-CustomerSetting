/*
	Created: Eden@20210208
	Task: insert update StakeLevel, StakeLevelGroupDetail for Saba.Club - SIT env [#147941]
	DB: DBCust/CustDB
*/
USE CUSTDB
GO

DECLARE @StakeLevel TABLE
(
	GameTypeID  INT DEFAULT 1611,
	ExchangeId  INT
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
UNION ALL SELECT 20

--UPDATE StakeLevel
UPDATE s 
SET s.GameGroupID = CASE WHEN s.GameGroupID = 20 THEN 13 ELSE 20 END
FROM StakeLevel s 
WHERE s.GameTypeID = 1611 
	AND s.ExchangeId IN(SELECT ExchangeId FROM @StakeLevel)

--UPDATE StakeLevelGroupDetail 
UPDATE g 
SET   g.MinLabel ='0.01'
	, g.MaxLabel = '3,000'
	, g.MinStake = 0.01
	, g.MaxStake = 3000
FROM StakeLevel s WITH (NOLOCK)
	INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) On s.StakeLevelID = g.StakeLevelID
WHERE s.GameTypeID = 1611 
	AND s.GameGroupID = 13
	AND s.ExchangeId IN(SELECT ExchangeId FROM @StakeLevel)

UPDATE g 
SET   g.MinLabel ='0.01'
	, g.MaxLabel = '5,000'
	, g.MinStake = 0.01
	, g.MaxStake = 5000
FROM StakeLevel s WITH (NOLOCK)
	INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) On s.StakeLevelID = g.StakeLevelID
WHERE s.GameTypeID = 1611 
	AND s.GameGroupID = 20
	AND s.ExchangeId IN(SELECT ExchangeId FROM @StakeLevel)


SELECT *
FROM StakeLevel s WITH (NOLOCK)
	INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) On s.StakeLevelID = g.StakeLevelID
WHERE s.GameTypeID = 1611 
	AND s.ExchangeId IN(SELECT ExchangeId FROM @StakeLevel)
