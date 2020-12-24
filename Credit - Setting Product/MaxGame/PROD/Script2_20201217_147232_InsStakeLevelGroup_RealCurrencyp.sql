/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Insert Setting StakeLevelGroupDetail for Max Game - Real currency [RM:#147232]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8),ExchangeId int, GameGroupID int default(19))
CREATE TABLE #OfferGameType (GameTypeID INT)

INSERT INTO #OfferGameType
SELECT 5401
UNION ALL SELECT 5402
UNION ALL SELECT 5403
UNION ALL SELECT 5405
UNION ALL SELECT 5406
UNION ALL SELECT 5407
UNION ALL SELECT 5408
UNION ALL SELECT 5409
								
INSERT INTO #StakeLevel_Temp(ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 15, '2', '20,000', 2, 20000 UNION ALL -- IN
SELECT 22, '2', '20,000', 2, 20000 UNION ALL -- IND
SELECT 33, '2', '20,000', 2, 20000 UNION ALL -- IDD
SELECT 34, '2', '20,000', 2, 20000 UNION ALL -- IDR
SELECT 47, '2', '20,000', 2, 20000 UNION ALL -- DDD
SELECT 6, '1', '1,000', 1, 1000 UNION ALL -- EURO
SELECT 12, '1', '1,000', 1, 1000 UNION ALL -- GBP
SELECT 5, '2', '5,000', 2, 5000 UNION ALL -- HK$
SELECT 67, '1', '5,000', 1, 5000 UNION ALL -- HKK
SELECT 51, '2', '50,000', 2, 50000 UNION ALL -- INH
SELECT 61, '50', '50,000', 50, 50000 UNION ALL -- INR
SELECT 2, '1', '5,000', 1, 5000 UNION ALL -- RM
SELECT 13, '2', '10,000', 2, 10000 UNION ALL -- RMB
SELECT 43, '10', '50,000', 10, 50000 UNION ALL -- THB
SELECT 3, '1', '2,000', 1, 2000 UNION ALL -- US$
SELECT 16, '1', '2,000', 1, 2000 UNION ALL -- Yen
SELECT 35, '1', '2,000', 1, 2000 UNION ALL -- $US
SELECT 64, '1', '2,000', 1, 2000 UNION ALL -- UT
SELECT 95, '1', '2,000', 1, 2000 UNION ALL -- USD
SELECT 45, '1,000', '1,000,000', 1000, 1000000 UNION ALL -- Won
SELECT 69, '1', '2,000', 1, 2000 -- MMK

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
WHERE g.GameTypeID BETWEEN 5401 AND 5409
	AND s.ExchangeId NOT IN(20,72)
*/