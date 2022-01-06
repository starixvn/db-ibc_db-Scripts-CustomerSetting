/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220106
	Created: Winfred 
	Task: #165587 - Spadegaming - 2 new games Jackpot - Credit  RedmineID:#165587
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,7    UNION ALL	--DON	--INH,YNG,UUS,DON
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,7    UNION ALL	--DON	--INH,YNG,UUS,DON
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4373 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4374 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4373 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4374 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4373 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4374 ,'0.08'   ,'1100'      ,0.08   ,1100.00   ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4373 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4374 ,'0.08'   ,'2200'      ,0.08   ,2200.00   ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4373 ,'0.8'    ,'11000'     ,0.8    ,11000.00  ,43   UNION ALL	--THB	--THB, TB
SELECT 4374 ,'0.8'    ,'11000'     ,0.8    ,11000.00  ,43   UNION ALL	--THB	--THB, TB
SELECT 4373 ,'8'      ,'110000'    ,8      ,110000.00 ,45   UNION ALL	--Won	--Won
SELECT 4374 ,'8'      ,'110000'    ,8      ,110000.00 ,45   UNION ALL	--Won	--Won
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4373 ,'0.08'   ,'220'       ,0.08   ,220.00    ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4374 ,'0.08'   ,'220'       ,0.08   ,220.00    ,16				--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS

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
