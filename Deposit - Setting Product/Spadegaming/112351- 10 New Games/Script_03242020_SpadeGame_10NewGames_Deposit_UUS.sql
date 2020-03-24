/*
	Date: 20200324
	Created: Eden
	Task: Spadegaming - Integrate 10 new games - Deposit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT 4327, 20, '0.1', '90', 0.10, 90 UNION ALL -- UUS
SELECT 4328, 20, '0.1', '90', 0.10, 90 UNION ALL -- UUS
SELECT 4329, 20, '0.09', '90', 0.09, 90 UNION ALL -- UUS
SELECT 4330, 20, '0.09', '45', 0.09, 45 UNION ALL -- UUS
SELECT 4331, 20, '0.09', '45', 0.09, 45 UNION ALL -- UUS
SELECT 4332, 20, '0.1', '90', 0.10, 90 UNION ALL -- UUS
SELECT 4333, 20, '0.1', '20', 0.10, 20 UNION ALL -- UUS
SELECT 4334, 20, '0.8', '100', 0.80, 100 UNION ALL -- UUS
SELECT 4335, 20, '0.09', '90', 0.09, 90 UNION ALL -- UUS
SELECT 4336, 20, '0.8', '120', 0.80, 120 UNION ALL -- UUS
SELECT 4327, 72, '0.5', '2,400', 0.50, 2400 UNION ALL -- YNG
SELECT 4328, 72, '0.2', '2,400', 0.20, 2400 UNION ALL -- YNG
SELECT 4329, 72, '0.9', '2,250', 0.90, 2250 UNION ALL -- YNG
SELECT 4330, 72, '0.9', '900', 0.90, 900 UNION ALL -- YNG
SELECT 4331, 72, '0.9', '900', 0.90, 900 UNION ALL -- YNG
SELECT 4332, 72, '0.5', '900', 0.50, 900 UNION ALL -- YNG
SELECT 4333, 72, '0.5', '1,500', 0.50, 1500 UNION ALL -- YNG
SELECT 4334, 72, '0.8', '2,000', 0.80, 2000 UNION ALL -- YNG
SELECT 4335, 72, '0.9', '2,250', 0.90, 2250 UNION ALL -- YNG
SELECT 4336, 72, '0.8', '1,200', 0.80, 1200 -- YNG

;WITH T AS(
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4301
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
