/*
	Date: 20200525
	Created: Elodie
	Task: Insert stake level for Keno Pro Viet
	DB: DBCUST/CUSTDB
*/

USE CustDB
GO

INSERT INTO dbo.Dep_StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, 1622, '1', '40,000', 1, 40000, NULL
FROM dbo.Dep_StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 1611 AND ExchangeId = 20

INSERT INTO dbo.Dep_StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT s.StakeLevelID, 1622, '1', '40,000', 1, 40000, NULL
FROM dbo.Dep_StakeLevel s WITH (NOLOCK)
WHERE GameTypeID = 1611 AND ExchangeId = 51

SELECT * FROM dbo.Dep_StakeLevel WITH (NOLOCK) WHERE GameTypeID = 1611
SELECT * FROM dbo.Dep_StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID IN (1611, 1622)
