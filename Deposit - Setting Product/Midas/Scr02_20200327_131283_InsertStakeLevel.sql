/*
	Created: Elodie
	Date: 20200331
	Task: Insert stakelevel of Midas for nova cash
*/
USE CustDB
GO

--DELETE Dep_StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1903

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'USD'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(1 AS NVARCHAR(50)),CAST(1000 AS NVARCHAR(50)), 1 , 1000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.Code = 'MYR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(10 AS NVARCHAR(50)),CAST(10000 AS NVARCHAR(50)), 10 , 10000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'THB'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(3 AS NVARCHAR(50)),CAST(4000 AS NVARCHAR(50)), 3 , 4000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.Code = 'IDR'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(5 AS NVARCHAR(50)),CAST(5000 AS NVARCHAR(50)), 5 , 5000
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.currency = 'INH'

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(2 AS NVARCHAR(50)),CAST(1500 AS NVARCHAR(50)), 2 , 1500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID = 10
	AND e.currency = 'RMB'

SELECT TOP 1000 s.*, sd.* 
FROM Dep_StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.Dep_StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=10


