/*
	Date: 2019-09-20
	Created: Winnie
	Task: add global setting for for credit #120070 -- UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GroupID INT,GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)

-- UUS
SELECT 4190,20,'0.01','25',0.01,25 UNION ALL 
SELECT 4191,20,'0.2','12',0.2,12 UNION ALL 
SELECT 4192,20,'0.1','50',0.1,50 UNION ALL 
SELECT 4193,20,'0.09','90',0.09,90 UNION ALL 
SELECT 4194,20,'0.2','8',0.2,8 UNION ALL 
SELECT 4195,20,'0.25','10',0.25,10 UNION ALL 
SELECT 4196,20,'0.05','50',0.05,50 UNION ALL 
SELECT 4197,20,'0.18','9',0.18,9

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
