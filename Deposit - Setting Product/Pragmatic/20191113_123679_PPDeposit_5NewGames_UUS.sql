/*
	Date: 2019-11-13
	Created: Tiara
	Task: #123679 Pragmatic - Integrate 5 games - Add global setting for Cash_UUS
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
--YNG, UUS

SELECT 4198, 72,'0.2',' 10', 0.2, 10 UNION ALL
SELECT 4199, 72,'0.1',' 1', 0.1, 1 UNION ALL
SELECT 4200, 72,'0.2',' 20', 0.2, 20 UNION ALL
SELECT 4201, 72,'0.05',' 15', 0.05, 15 UNION ALL
SELECT 4202, 72,'0.25',' 2.5', 0.25, 2.5 UNION ALL
SELECT 4198, 20,'0.2',' 10', 0.2, 10 UNION ALL
SELECT 4199, 20,'0.1',' 1', 0.1, 1 UNION ALL
SELECT 4200, 20,'0.2',' 20', 0.2, 20 UNION ALL
SELECT 4201, 20,'0.05',' 15', 0.05, 15 UNION ALL
SELECT 4202, 20,'0.25',' 2.5', 0.25, 2.5

;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
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
