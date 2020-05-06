/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20200506
	Task: Insert stakelevel of HILO for 789y
*/
USE CustDB
GO

--DELETE StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1905

INSERT INTO StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT s.StakeLevelID, 1905, sd.MinLabel, sd.MaxLabel, sd.MinStake,	sd.MaxStake
FROM dbo.StakeLevel s WITH(NOLOCK) 	
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.exchangeid
	INNER JOIN dbo.StakeLevelGroupDetail sd WITH (NOLOCK) ON sd.StakeLevelID = s.StakeLevelID
WHERE s.GameTypeID = 1901 AND s.GameGroupID = 9
	AND e.Code = 'USD'
	AND sd.GameTypeID = 1901

SELECT TOP 1000 s.*, sd.* 
FROM StakeLevelGroupDetail sd WITH (NOLOCK) 
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = sd.StakeLevelID
WHERE s.GameTypeID = 1901 AND GameGroupID=9


