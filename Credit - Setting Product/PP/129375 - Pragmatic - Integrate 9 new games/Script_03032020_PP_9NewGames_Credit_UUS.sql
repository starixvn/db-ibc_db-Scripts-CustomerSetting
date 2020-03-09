/*
	Date: 20200303
	Created: Eden
	Task: #129375 - Pragmatic - Integrate 9 new games - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GroupID INT DEFAULT 6,GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT 4203, 20, '0.2', '4', 0.20, 4.0 UNION ALL -- UUS
SELECT 4204, 20, '0.25', '20', 0.25, 20.0 UNION ALL -- UUS
SELECT 4205, 20, '0.2', '10', 0.20, 10.0 UNION ALL -- UUS
SELECT 4206, 20, '0.25', '37.5', 0.25, 37.5 UNION ALL -- UUS
SELECT 4207, 20, '0.08', '100', 0.08, 100.0 UNION ALL -- UUS
SELECT 4208, 20, '0.2', '6', 0.20, 6.0 UNION ALL -- UUS
SELECT 4209, 20, '0.5', '60', 0.50, 60.0 UNION ALL -- UUS
SELECT 4210, 20, '0.5', '8', 0.50, 8.0 UNION ALL -- UUS
SELECT 4211, 20, '0.25', '50', 0.25, 50.0 UNION ALL -- UUS
SELECT 4203, 72, '0.2', '4', 0.20, 4.0 UNION ALL -- YNG
SELECT 4204, 72, '0.25', '20', 0.25, 20.0 UNION ALL -- YNG
SELECT 4205, 72, '0.2', '10', 0.20, 10.0 UNION ALL -- YNG
SELECT 4206, 72, '0.25', '37.5', 0.25, 37.5 UNION ALL -- YNG
SELECT 4207, 72, '0.08', '100', 0.08, 100.0 UNION ALL -- YNG
SELECT 4208, 72, '0.2', '6', 0.20, 6.0 UNION ALL -- YNG
SELECT 4209, 72, '0.5', '60', 0.50, 60.0 UNION ALL -- YNG
SELECT 4210, 72, '0.5', '8', 0.50, 8.0 UNION ALL -- YNG
SELECT 4211, 72, '0.25', '50', 0.25, 50.0 -- YNG

;WITH T AS(
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = t.GroupID) t
WHERE s.GameTypeID = 4101
)
MERGE StakeLevelGroupDetail as g 
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
