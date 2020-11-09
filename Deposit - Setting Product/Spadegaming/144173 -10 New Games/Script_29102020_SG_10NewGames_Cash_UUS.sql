/*
	Date: 20201029
	Created: Winfred 
	Task: #144173 - Spadegaming - 10 new games Oct 2020 - Cash UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(11))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
--YNG
SELECT 4310 ,'1'    ,'2000'    ,1    ,2000    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4345 ,'1'    ,'2000'    ,1    ,2000    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4346 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4347 ,'0.5'  ,'1250'    ,0.5  ,1250    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4348 ,'0.5'  ,'1250'    ,0.5  ,1250    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4352 ,'0.9'  ,'2250'    ,0.9  ,2250    ,72   UNION ALL	--YNG	--YNG,UUS,INH
SELECT 4353 ,'1'    ,'2000'    ,1    ,2000    ,72				--YNG	--YNG,UUS,INH		


UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4301)

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