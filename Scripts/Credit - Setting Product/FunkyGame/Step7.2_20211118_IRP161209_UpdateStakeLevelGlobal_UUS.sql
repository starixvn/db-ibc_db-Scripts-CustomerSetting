/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20211118
	Task: Update global settings for Funky Games - UUS [RM#161209]
	DB: DBCust/CustDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8),ExchangeId int)
								
INSERT INTO #StakeLevel_Temp(ExchangeId,GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
		SELECT 	20	,	5500	,	20	,	20000	,	'20'	,	'20,000'	-- UUS

UPDATE g
SET g.MinStake = t.MinStake,
	g.MaxStake = t.MaxStake,
	g.MinLabel = t.MinLabel,
	g.MaxLabel = t.MaxLabel
FROM StakeLevelGroupDetail g WITH(ROWLOCK)
	INNER JOIN StakeLevel s WITH(NOLOCK) ON s.StakeLevelID = g.StakeLevelID
	INNER JOIN #StakeLevel_Temp t ON g.GameTypeID = t.GameTypeID AND s.ExchangeId = t.ExchangeID	
WHERE g.MinStake <> t.MinStake
	OR g.MaxStake <> t.MaxStake

DROP TABLE #StakeLevel_Temp

