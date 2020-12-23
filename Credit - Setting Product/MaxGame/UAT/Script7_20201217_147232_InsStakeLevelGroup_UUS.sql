/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Insert Setting StakeLevelGroupDetail Max Game - Credit - UUS [RM:#147232]
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8),ExchangeId int, GameGroupID int default(19))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 5401, 20, '1', '2,000', 1, 2000 UNION ALL -- UUS
SELECT 5401, 72, '1', '2,000', 1, 2000 -- YNG

;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY (	SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
					FROM #StakeLevel_Temp t 
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

/*
SELECT * 
FROM StakeLevelGroupDetail g (NOLOCK)
	INNER JOIN StakeLevel s (NOLOCK) ON g.StakeLevelID = s.StakeLevelID
WHERE g.GameTypeID = 5401
	AND s.ExchangeId IN(20,72)
*/