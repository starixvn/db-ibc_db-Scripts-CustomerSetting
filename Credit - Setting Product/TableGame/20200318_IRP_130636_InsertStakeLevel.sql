/*
	Created: 20200318@Elodie
	Task: Insert stake level for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

INSERT INTO	dbo.GameGroup (GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit)      
VALUES	(13, 200, 1611, 'Level 1', 0)

INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT 1611, NULL, NULL, NULL, NULL, exchangeid, NULL, 13
FROM dbo.exchange WITH (NOLOCK)
WHERE Code = 'USD' OR exchangeid = 20

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, GameTypeID, '0.01', '200', 0.01, 200, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 1611  

SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 1611 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = 1611
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.GameGroup WITH (ROWLOCK) WHERE RefBetType = 1611
--DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1611
