/*
	Date: 20200421
	Created: Eden
	Task: #132719 - Pragmatic - Integrate 6 new games - Deposit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT 4212, 20, '0.3', '3', 0.3, 3 UNION ALL -- UUS
SELECT 4213, 20, '0.1', '5', 0.1, 5 UNION ALL -- UUS
SELECT 4214, 20, '0.2', '6', 0.2, 6 UNION ALL -- UUS
SELECT 4215, 20, '0.2', '4', 0.2, 4 UNION ALL -- UUS
SELECT 4216, 20, '0.4', '12', 0.4, 12 UNION ALL -- UUS
SELECT 4217, 20, '0.1', '4', 0.1, 4 UNION ALL -- UUS
SELECT 4212, 72, '0.3', '3', 0.3, 3 UNION ALL -- YNG
SELECT 4213, 72, '0.1', '5', 0.1, 5 UNION ALL -- YNG
SELECT 4214, 72, '0.2', '6', 0.2, 6 UNION ALL -- YNG
SELECT 4215, 72, '0.2', '4', 0.2, 4 UNION ALL -- YNG
SELECT 4216, 72, '0.4', '12', 0.4, 12 UNION ALL -- YNG
SELECT 4217, 72, '0.1', '4', 0.1, 4  -- YNG

;WITH T AS(
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);
   							
DROP TABLE #tmpStake
