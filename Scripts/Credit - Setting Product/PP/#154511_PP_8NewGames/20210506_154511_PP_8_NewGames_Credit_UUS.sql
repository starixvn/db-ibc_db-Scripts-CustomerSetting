/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210506@Eden
	Task: Pragmatic - Integrate 8 new games Credit UUS [Redmine:#154511]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT 4258, 20, '0.1', '50', 0.10, 50 UNION ALL -- UUS
SELECT 4259, 20, '0.25', '50', 0.25, 50 UNION ALL -- UUS
SELECT 4260, 20, '0.2', '10', 0.20, 10 UNION ALL -- UUS
SELECT 4261, 20, '0.2', '60', 0.20, 60 UNION ALL -- UUS
SELECT 4262, 20, '0.05', '100', 0.05, 100 UNION ALL -- UUS
SELECT 4263, 20, '0.1', '10', 0.10, 10 UNION ALL -- UUS
SELECT 4264, 20, '0.25', '25', 0.25, 25 UNION ALL -- UUS
SELECT 4265, 20, '0.2', '10', 0.20, 10 UNION ALL -- UUS
SELECT 4258, 72, '0.1', '50', 0.10, 50 UNION ALL -- YNG
SELECT 4259, 72, '0.25', '50', 0.25, 50 UNION ALL -- YNG
SELECT 4260, 72, '0.2', '10', 0.20, 10 UNION ALL -- YNG
SELECT 4261, 72, '0.2', '60', 0.20, 60 UNION ALL -- YNG
SELECT 4262, 72, '0.05', '100', 0.05, 100 UNION ALL -- YNG
SELECT 4263, 72, '0.1', '10', 0.10, 10 UNION ALL -- YNG
SELECT 4264, 72, '0.25', '25', 0.25, 25 UNION ALL -- YNG
SELECT 4265, 72, '0.2', '10', 0.20, 10 -- YNG

;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel_Temp t 
				  WHERE t.ExchangeId = s.ExchangeId 
				  AND t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 4101
)
MERGE StakeLevelGroupDetail as g 
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
