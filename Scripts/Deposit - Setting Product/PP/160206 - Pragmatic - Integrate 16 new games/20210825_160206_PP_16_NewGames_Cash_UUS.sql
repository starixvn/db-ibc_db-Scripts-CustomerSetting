/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210825
	Created: Winfred 
	Task: #160206 - Pragmatic - Integrate 16 new games for Deposit UUS [Redmine:160206]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--YNG,UUS
SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,20   UNION ALL	--UUS	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,72   UNION ALL	--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,72				--YNG	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF

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