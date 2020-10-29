/*
	Date: 20201029
	Created: Winfred 
	Task: #144173 - Spadegaming - 10 new games Oct 2020 - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--YNG
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,72				--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS			

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4301)

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