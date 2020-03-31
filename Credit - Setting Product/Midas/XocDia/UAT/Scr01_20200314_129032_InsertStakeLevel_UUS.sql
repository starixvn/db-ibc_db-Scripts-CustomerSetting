/*
	Created: Elodie
	Date: 20200314
	Task: Insert stakelevel of Midas for 789y
*/
USE CustDB
GO

--DELETE StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1903

INSERT INTO StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID, 1903, CAST(1 AS NVARCHAR(50)),CAST(500 AS NVARCHAR(50)), 1 , 500
FROM StakeLevel s WITH(NOLOCK) 
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
WHERE GameTypeID=1901 AND GameGroupID=9
	AND e.exchangeid = 20

SELECT TOP 1000 s.*, sd.* 
FROM StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=9


