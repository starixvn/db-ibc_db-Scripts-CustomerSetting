/*
	Date: 20200421
	Created: Eden
	Task: #132719 - Pragmatic - Integrate 6 new games - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GroupID INT DEFAULT 6,GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT 4212, 20, '0.3', '6', 0.3, 6 UNION ALL -- UUS
SELECT 4213, 20, '0.1', '10', 0.1, 10 UNION ALL -- UUS
SELECT 4214, 20, '0.2', '10', 0.2, 10 UNION ALL -- UUS
SELECT 4215, 20, '0.2', '8', 0.2, 8 UNION ALL -- UUS
SELECT 4216, 20, '0.4', '32', 0.4, 32 UNION ALL -- UUS
SELECT 4217, 20, '0.1', '10', 0.1, 10 UNION ALL -- UUS
SELECT 4212, 72, '0.3', '6', 0.3, 6 UNION ALL -- YNG
SELECT 4213, 72, '0.1', '10', 0.1, 10 UNION ALL -- YNG
SELECT 4214, 72, '0.2', '10', 0.2, 10 UNION ALL -- YNG
SELECT 4215, 72, '0.2', '8', 0.2, 8 UNION ALL -- YNG
SELECT 4216, 72, '0.4', '32', 0.4, 32 UNION ALL -- YNG
SELECT 4217, 72, '0.1', '10', 0.1, 10 -- YNG

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
