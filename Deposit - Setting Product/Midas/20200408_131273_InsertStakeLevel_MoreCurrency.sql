/*
	Created: Elodie
	Date: 20200408
	Task: Insert stakelevel of Midas for more currency
*/
USE CustDB
GO

--DELETE Dep_StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1902

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1902, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'EUR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1902, CAST(1000 AS NVARCHAR(50)),CAST(500000 AS NVARCHAR(50)), 1000 , 500000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'KRW'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1902, CAST(100 AS NVARCHAR(50)),CAST(50000 AS NVARCHAR(50)), 100 , 50000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'JPY'

SELECT TOP 1000 s.*, sd.* 
FROM Dep_StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.Dep_StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=10


