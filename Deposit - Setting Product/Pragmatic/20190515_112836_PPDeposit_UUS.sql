/*
	Date: 2019-05-20
	Created: Winnie
	Task: add global setting for for cash
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
--UUS
SELECT 4121,20,'0.05','80',0.05,80 UNION ALL 
SELECT 4144,20,'0.09','6.3',0.09,6.3 UNION ALL 
SELECT 4130,20,'0.25','10',0.25,10 UNION ALL 
SELECT 4161,20,'0.1','6',0.1,6 UNION ALL 
SELECT 4142,20,'0.25','10',0.25,10 UNION ALL 
SELECT 4156,20,'0.25','10',0.25,10 UNION ALL 
SELECT 4132,20,'0.5','5',0.5,5 UNION ALL 
SELECT 4168,20,'0.1','20',0.1,20 UNION ALL 
SELECT 4172,20,'0.25','2.5',0.25,2.5 UNION ALL 
SELECT 4175,20,'0.2','5',0.2,5 UNION ALL 
SELECT 4179,20,'0.18','3.6',0.18,3.6 UNION ALL 
SELECT 4180,20,'0.25','10',0.25,10 UNION ALL 
SELECT 4181,20,'0.25','5',0.25,5 UNION ALL 
SELECT 4182,20,'0.1','1',0.1,1 UNION ALL 
SELECT 4183,20,'0.2','48',0.2,48 UNION ALL 
SELECT 4184,20,'0.2','4',0.2,4 UNION ALL 
SELECT 4185,20,'0.25','2.5',0.25,2.5 UNION ALL 
SELECT 4186,20,'0.2','2',0.2,2 

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
