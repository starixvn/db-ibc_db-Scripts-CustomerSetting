/*
	Created: 20200525@Elodie
	Task: Insert stake level for Keno Pro Viet
	DB: DBCUST/CustDB
*/

USE CustDB
GO

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, 1622, '1', '20,000', 1, 20000, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 1611 AND ExchangeId = 20

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT s.StakeLevelID, 1622, '1', '2,000', 1, 2000, NULL
FROM dbo.StakeLevel s WITH (NOLOCK)
	INNER JOIN exchange e WITH (NOLOCK) ON s.ExchangeId = e.ExchangeId
WHERE s.GameTypeID = 1611 AND Code = 'USD'

SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 1611 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = 1611
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID IN (1611, 1622)
--DELETE FROM dbo.GameGroup WITH (ROWLOCK) WHERE RefBetType = 1611
--DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1611
