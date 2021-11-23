/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211110
	Created: Winfred 
	Task: #164090 - Spadegaming - 10 new games 2021 - UUS deposit  RedmineID:#164090
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(11))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
--YNG
SELECT 4363 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4364 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4365 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4367 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4369 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4370 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,72   UNION ALL	--YNG	--INH,YNG,UUS
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,72   			--YNG	--INH,YNG,UUS

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