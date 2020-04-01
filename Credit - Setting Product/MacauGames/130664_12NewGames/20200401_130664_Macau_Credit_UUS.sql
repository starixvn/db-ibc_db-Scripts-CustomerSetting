/*
	Date: 20200401
	Created: Tiara
	Task: #130644 - Macau games - Integrate 12 new games - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GroupID INT DEFAULT 1,GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT 4044,20,'0.4','40',0.4,40 UNION ALL
SELECT 4045,20,'0.25','12.5',0.25,12.5 UNION ALL
SELECT 4046,20,'0.27','27',0.27,27 UNION ALL
SELECT 4047,20,'0.15','15',0.15,15 UNION ALL
SELECT 4048,20,'0.15','15',0.15,15 UNION ALL
SELECT 4049,20,'0.4','40',0.4,40 UNION ALL
SELECT 4050,20,'0.5','50',0.5,50 UNION ALL
SELECT 4051,20,'0.2','4',0.2,4 UNION ALL
SELECT 4052,20,'0.2','4',0.2,4 UNION ALL
SELECT 4053,20,'0.1','4',0.1,4 UNION ALL
SELECT 4054,20,'0.1','4',0.1,4 UNION ALL
SELECT 4055,20,'0.1','10',0.1,10

;WITH T AS(
SELECT S.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake
FROM StakeLevel S WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = t.GroupID) t
WHERE S.GameTypeID = 4001
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
