/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Insert Setting StakeLevelGroupDetail Max Game - Credit - UUS [RM:#147232]
	DB: DBCust/CustDB
*/
DELETE g
FROM StakeLevelGroupDetail g WITH(ROWLOCK)
	INNER JOIN StakeLevel s (NOLOCK) ON g.StakeLevelID = s.StakeLevelID
WHERE g.GameTypeID BETWEEN 5401 AND 5410
	AND s.ExchangeId IN(20,72)

CREATE TABLE #StakeLevel_Temp (MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8),ExchangeId int, GameGroupID int default(19))

CREATE TABLE #OfferGameType (GameTypeID INT)
INSERT INTO #OfferGameType
SELECT 5402
UNION ALL SELECT 5403
UNION ALL SELECT 5404
UNION ALL SELECT 5406
UNION ALL SELECT 5407
UNION ALL SELECT 5408
UNION ALL SELECT 5409
UNION ALL SELECT 5410
								
INSERT INTO #StakeLevel_Temp(ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 20, '1', '2,000', 1, 2000 UNION ALL -- UUS
SELECT 72, '1', '2,000', 1, 2000 -- YNG

;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY (	SELECT g.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
					FROM #StakeLevel_Temp t 
						 CROSS JOIN #OfferGameType g
					WHERE t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 5401
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
DROP TABLE #OfferGameType

/*
SELECT * 
FROM StakeLevelGroupDetail g (NOLOCK)
	INNER JOIN StakeLevel s (NOLOCK) ON g.StakeLevelID = s.StakeLevelID
WHERE g.GameTypeID BETWEEN 5401 AND 5410
	AND s.ExchangeId IN(20,72)
*/