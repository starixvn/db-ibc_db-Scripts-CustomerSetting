/*
	Created: Elodie
	Date: 20200420
	Task: Insert stakelevel of 3DGame
*/
USE CustDB
GO

--DELETE Dep_StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1904

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'USD'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'EUR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(2 AS NVARCHAR(50)),CAST(1500 AS NVARCHAR(50)), 2 , 1500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'MYR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(2 AS NVARCHAR(50)),CAST(1500 AS NVARCHAR(50)), 2 , 1500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'HKD'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(2 AS NVARCHAR(50)),CAST(1500 AS NVARCHAR(50)), 2 , 1500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'CNY'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(6 AS NVARCHAR(50)),CAST(4500 AS NVARCHAR(50)), 6 , 4500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'IDR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(20 AS NVARCHAR(50)),CAST(15000 AS NVARCHAR(50)), 20 , 15000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'THB'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(10 AS NVARCHAR(50)),CAST(7500 AS NVARCHAR(50)), 10 , 7500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.currency = 'INH'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(1000 AS NVARCHAR(50)),CAST(750000 AS NVARCHAR(50)), 1000 , 750000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'KRW'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1904, CAST(100 AS NVARCHAR(50)),CAST(75000 AS NVARCHAR(50)), 100 , 75000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'JPY'

SELECT TOP 1000 s.*, sd.* 
FROM Dep_StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.Dep_StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=10


