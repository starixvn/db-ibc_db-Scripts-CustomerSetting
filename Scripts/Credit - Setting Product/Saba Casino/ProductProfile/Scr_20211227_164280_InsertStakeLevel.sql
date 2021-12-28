/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert stake level for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

INSERT INTO	dbo.GameGroup (GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit)      
VALUES	
	(33, 208, 2101, 'Level 1', 1),
	(34, 208, 2101, 'Level 1', 0),
	(35, 208, 2101, 'Level 2', 1),
	(36, 208, 2101, 'Level 2', 0)

INSERT INTO dbo.StakeLevel (GameTypeID, ExchangeId, ResourceId, GameGroupID)
SELECT 2101, 20, NULL, 34 UNION ALL
SELECT 2101, 20, NULL, 36

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, GameTypeID, '0.01', '200', 0.01, 200, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 2101 AND GameGroupID = 34
UNION ALL
SELECT StakeLevelID, GameTypeID, '0.01', '200', 0.01, 200, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 2101 AND GameGroupID = 36  

SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 2101 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = 2101
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 2101
--DELETE FROM dbo.GameGroup WITH (ROWLOCK) WHERE RefBetType = 1611
--DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1611
