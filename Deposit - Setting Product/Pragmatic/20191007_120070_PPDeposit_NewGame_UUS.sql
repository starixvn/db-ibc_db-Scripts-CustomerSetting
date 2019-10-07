/*
	Date: 2019-09-23
	Created: Winnie
	Task: add global setting for for cash #120070 -- UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)


SELECT 4190,20,'0.1','10',0.1,10 UNION ALL 
SELECT 4191,20,'0.2','4',0.2,4 UNION ALL 
SELECT 4192,20,'0.1','20',0.1,20 UNION ALL 
SELECT 4193,20,'0.09','27',0.09,27 UNION ALL 
SELECT 4194,20,'0.2','2',0.2,2 UNION ALL 
SELECT 4195,20,'0.25','2.5',0.25,2.5 UNION ALL 
SELECT 4196,20,'0.05','15',0.05,15 UNION ALL 
SELECT 4197,20,'0.18','5.4',0.18,5.4

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
