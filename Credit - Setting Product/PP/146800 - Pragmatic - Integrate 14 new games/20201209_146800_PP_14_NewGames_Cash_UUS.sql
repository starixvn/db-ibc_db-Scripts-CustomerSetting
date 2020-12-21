/*
	Date: 20201209
	Created: Winfred 
	Task: #146800 - Pragmatic - Integrate 14 new games Dec 2020 for Cash UUS [Redmine:146800]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,72				--YNG	--USD,EUR,SGD,AUD,YNG,UUS

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