/*
	Date: 2019-11-13
	Created: Tiara
	Task: #123679 Pragmatic - Integrate 5 games - Add global setting for Credit_UUS
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpStake(GroupID INT,GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
--UUS
SELECT 4198, 20,'200',' 20000', 200, 20000 UNION ALL
SELECT 4199, 20,'100',' 2000', 100, 2000 UNION ALL
SELECT 4200, 20,'200',' 40000', 200, 40000 UNION ALL
SELECT 4201, 20,'50',' 50000', 50, 50000 UNION ALL
SELECT 4202, 20,'250',' 7500', 250, 7500 UNION ALL
--YNG
SELECT 4198, 72,'200',' 20000', 200, 20000 UNION ALL
SELECT 4199, 72,'100',' 2000', 100, 2000 UNION ALL
SELECT 4200, 72,'200',' 40000', 200, 40000 UNION ALL
SELECT 4201, 72,'50',' 50000', 50, 50000 UNION ALL
SELECT 4202, 72,'250',' 7500', 250, 7500

UPDATE #tmpStake
SET GroupID=6

;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = t.GroupID) t
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
