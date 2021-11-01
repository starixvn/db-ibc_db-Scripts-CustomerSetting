/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 202111101
	Created: Winfred 
	Task: #163502 - Pragmatic - Integrate 10 new games for Deposit UUS [Redmine:163502]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--YNG,UUS
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.45' ,'4.5'     ,0.45 ,4.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.45' ,'4.5'     ,0.45 ,4.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,72				--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF

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