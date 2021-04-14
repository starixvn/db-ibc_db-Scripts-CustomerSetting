/*
	Date: 20210409
	Created: Winfred 
	Task: #152755 - Spadegaming - 9 new games Mar 2021 - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
--YNG
SELECT 4354 ,'0.8'  ,'1000'    ,0.8  ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4355 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4356 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4357 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4358 ,'0.9'  ,'900'     ,0.9  ,900     ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4359 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4360 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4361 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4362 ,'1'    ,'1000'    ,1    ,1000    ,72				--YNG	--INH,YNG,UUS

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

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