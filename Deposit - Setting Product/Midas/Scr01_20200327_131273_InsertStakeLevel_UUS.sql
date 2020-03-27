/*
	Created: Elodie
	Date: 20200327
	Task: Insert stakelevel of Midas for nova cash
*/
USE CustDB
GO

--DELETE Dep_StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1902

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1902, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM Dep_StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID = 1901 AND GameGroupID = 10
	AND e.exchangeid = 20

SELECT TOP 1000 s.*, sd.* 
FROM Dep_StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.Dep_StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=10


