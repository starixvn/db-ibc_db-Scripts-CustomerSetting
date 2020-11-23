/*
	Date: 20201118
	Created: Winfred 
	Task: #145333 - Spadegaming - 1 new games Nov 2020 - Credit
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4326 ,'0.05' ,'100'     ,0.05 ,100     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4326 ,'0.05' ,'100'     ,0.05 ,100     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4326 ,'0.05' ,'100'     ,0.05 ,100     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4326 ,'0.05' ,'100'     ,0.05 ,100     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4326 ,'0.05' ,'100'     ,0.05 ,100     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--Euro, EUR,GBP
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
--INH
SELECT 4326 ,'0.1'  ,'500'     ,0.1  ,500     ,51   UNION ALL	--INH	--INH,YNG,UUS
--RM,HKK, HK$,PLN,KHR
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
--RMB, CY, YUN,NOK,SEK
SELECT 4326 ,'0.1'  ,'100'     ,0.1  ,100     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4326 ,'0.1'  ,'100'     ,0.1  ,100     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4326 ,'0.1'  ,'100'     ,0.1  ,100     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4326 ,'0.1'  ,'100'     ,0.1  ,100     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4326 ,'0.1'  ,'100'     ,0.1  ,100     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
--RUB,INR,JPY
SELECT 4326 ,'1'    ,'2000'    ,1    ,2000    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4326 ,'1'    ,'2000'    ,1    ,2000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4326 ,'1'    ,'2000'    ,1    ,2000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
--THB, TB
SELECT 4326 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--THB, TB
SELECT 4326 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--THB, TB
--Won
SELECT 4326 ,'10'   ,'20000'   ,10   ,20000   ,45   UNION ALL	--Won	--Won
--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4326 ,'0.01' ,'10'      ,0.01 ,10      ,16				--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK

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
