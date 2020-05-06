/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20200506
	Task: Insert stakelevel of HILO
*/
USE CustDB
GO

--DELETE Dep_StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1905

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT s.StakeLevelID, 1905, sd.MinLabel, sd.MaxLabel, sd.MinStake,	sd.MaxStake
FROM dbo.Dep_StakeLevel s WITH(NOLOCK) 	
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
	INNER JOIN dbo.Dep_StakeLevelGroupDetail sd WITH (NOLOCK) ON sd.StakeLevelID = s.StakeLevelID
WHERE s.GameTypeID = 1901 AND s.GameGroupID = 10
	AND e.exchangeid = 20
	AND sd.GameTypeID = 1901

SELECT TOP 1000 s.*, sd.* 
FROM Dep_StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.Dep_StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=10


