/*
	Date: 20200731
	Created: Winfred 
	Task: #138659 - Pragmatic - Update setting for 7 New Jackpot Games for Credit -UUS [Redmine:138481]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--USD code($US, US$, UT, Yen),MMK, Euro, EUR,UUS, YNG
--UUS
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,20   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,20   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,20   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,20   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,20   UNION ALL
--YNG
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,72   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,72   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,72   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,72   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,72   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,72   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,72   
--=============================================

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

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