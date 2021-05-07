/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210506@Eden
	Task: Pragmatic - Integrate 8 new games Cash UUS [Redmine:#154511]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int, GameGroupID int default(8))
									
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 4258, 20, '0.1', '15', 0.10, 15 UNION ALL -- UUS
SELECT 4259, 20, '0.25', '15', 0.25, 15 UNION ALL -- UUS
SELECT 4260, 20, '0.2', '4', 0.20, 4 UNION ALL -- UUS
SELECT 4261, 20, '0.2', '16', 0.20, 16 UNION ALL -- UUS
SELECT 4262, 20, '0.05', '15', 0.05, 15 UNION ALL -- UUS
SELECT 4263, 20, '0.1', '3', 0.10, 3 UNION ALL -- UUS
SELECT 4264, 20, '0.25', '10', 0.25, 10 UNION ALL -- UUS
SELECT 4265, 20, '0.2', '4', 0.20, 4 UNION ALL -- UUS
SELECT 4258, 72, '0.1', '15', 0.10, 15 UNION ALL -- YNG
SELECT 4259, 72, '0.25', '15', 0.25, 15 UNION ALL -- YNG
SELECT 4260, 72, '0.2', '4', 0.20, 4 UNION ALL -- YNG
SELECT 4261, 72, '0.2', '16', 0.20, 16 UNION ALL -- YNG
SELECT 4262, 72, '0.05', '15', 0.05, 15 UNION ALL -- YNG
SELECT 4263, 72, '0.1', '3', 0.10, 3 UNION ALL -- YNG
SELECT 4264, 72, '0.25', '10', 0.25, 10 UNION ALL -- YNG
SELECT 4265, 72, '0.2', '4', 0.20, 4 -- YNG

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId
			   AND  t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)
MERGE Dep_StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;

DROP TABLE #StakeLevel_Temp