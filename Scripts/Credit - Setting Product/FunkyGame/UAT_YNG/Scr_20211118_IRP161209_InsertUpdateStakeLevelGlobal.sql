/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20211118
	Task: Insert Update global settings for Funky Games [RM#161209]
	DB: DBCust/CustDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(32))
								
INSERT INTO #StakeLevel_Temp(ExchangeId,GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
		SELECT 	20	,	5500	,	20	,	20000	,	'20'	,	'20,000'	-- UUS
UNION SELECT 	72	,	5500	,	20	,	20000	,	'20'	,	'20,000'	-- YNG
UNION SELECT 	72	,	5501	,	100	,	15000	,	'100'	,	'15,000'	-- YNG
UNION SELECT 	72	,	5502	,	100	,	15000	,	'100'	,	'15,000'	-- YNG
UNION SELECT 	72	,	5503	,	100	,	15000	,	'100'	,	'15,000'	-- YNG
UNION SELECT 	72	,	5504	,	100	,	15000	,	'100'	,	'15,000'	-- YNG
UNION SELECT 	72	,	5505	,	100	,	15000	,	'100'	,	'15,000'	-- YNG
UNION SELECT 	72	,	5506	,	10	,	2000	,	'10'	,	'2,000'	-- YNG
UNION SELECT 	72	,	5507	,	10	,	2000	,	'10'	,	'2,000'	-- YNG
UNION SELECT 	72	,	5508	,	10	,	2000	,	'10'	,	'2,000'	-- YNG
UNION SELECT 	72	,	5509	,	10	,	2000	,	'10'	,	'2,000'	-- YNG

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT t.gametypeid, t.ExchangeId,t.GameGroupID
FROM #StakeLevel_Temp t
	LEFT JOIN StakeLevel s WITH(NOLOCK) 
		ON t.exchangeid = s.ExchangeId AND t.GameTypeID = s.GameTypeID
WHERE t.gametypeid = 5500
	AND s.ExchangeId IS NULL
ORDER BY exchangeid 

;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 5500
)
MERGE StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake);

DROP TABLE #StakeLevel_Temp

