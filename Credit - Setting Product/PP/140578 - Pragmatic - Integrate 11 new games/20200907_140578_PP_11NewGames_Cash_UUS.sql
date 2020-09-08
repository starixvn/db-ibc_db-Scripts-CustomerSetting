/*
	Date: 20200610
	Created: Winfred 
	Task:  Pragmatic - Integrate 11 new games for Cash - UUS RedmineID:#140578
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'4.5'     ,0.09 ,4.5     ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
--YNG
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'4.5'     ,0.09 ,4.5     ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,72				--YNG	--USD,EUR, YNG,UUS

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
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