/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Add more stakelevel for all currencies of Pragmatic Live Casino [ RedmineID:#165157]
	DB: DBCUST/CustDB
	P/s : Step 1 Add global setting UUS
*/ 
USE CustDB
GO

CREATE TABLE #StakeLevel_Temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #StakeLevel_Temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake , ExchangeId )
--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'25000'     ,2      ,25000.00  ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'10000'     ,2      ,10000.00  ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'5000'      ,2      ,5000.00   ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'25000'     ,2      ,25000.00  ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'10000'     ,2      ,10000.00  ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'5000'      ,2      ,5000.00   ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'25000'     ,2      ,25000.00  ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'10000'     ,2      ,10000.00  ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'5000'      ,2      ,5000.00   ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'25000'     ,2      ,25000.00  ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'10000'     ,2      ,10000.00  ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'5000'      ,2      ,5000.00   ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'25000'     ,2      ,25000.00  ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'10000'     ,2      ,10000.00  ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 3701 ,'2'      ,'5000'      ,2      ,5000.00   ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--GBP
SELECT 3701 ,'0.1'    ,'625'       ,0.1    ,625.00    ,12   UNION ALL	--GBP	--GBP
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,12   UNION ALL	--GBP	--GBP
SELECT 3701 ,'0.1'    ,'125'       ,0.1    ,125.00    ,12   UNION ALL	--GBP	--GBP
--HKK
SELECT 3701 ,'0.4'    ,'5000'      ,0.4    ,5000.00   ,67   UNION ALL	--HKK	--HKK
SELECT 3701 ,'0.4'    ,'2000'      ,0.4    ,2000.00   ,67   UNION ALL	--HKK	--HKK
SELECT 3701 ,'0.4'    ,'1000'      ,0.4    ,1000.00   ,67   UNION ALL	--HKK	--HKK
--INH
SELECT 3701 ,'1'      ,'12500'     ,1      ,12500.00  ,51   UNION ALL	--INH	--INH
SELECT 3701 ,'1'      ,'5000'      ,1      ,5000.00   ,51   UNION ALL	--INH	--INH
SELECT 3701 ,'1'      ,'2500'      ,1      ,2500.00   ,51   UNION ALL	--INH	--INH
--RM
SELECT 3701 ,'0.4'    ,'5000'      ,0.4    ,5000.00   ,2    UNION ALL	--RM	--RM
SELECT 3701 ,'0.4'    ,'2000'      ,0.4    ,2000.00   ,2    UNION ALL	--RM	--RM
SELECT 3701 ,'0.4'    ,'1000'      ,0.4    ,1000.00   ,2    UNION ALL	--RM	--RM
--RMB,HK$
SELECT 3701 ,'0.4'    ,'5000'      ,0.4    ,5000.00   ,5    UNION ALL	--HK$	--RMB,HK$
SELECT 3701 ,'0.4'    ,'2000'      ,0.4    ,2000.00   ,5    UNION ALL	--HK$	--RMB,HK$
SELECT 3701 ,'0.4'    ,'1000'      ,0.4    ,1000.00   ,5    UNION ALL	--HK$	--RMB,HK$
SELECT 3701 ,'0.4'    ,'5000'      ,0.4    ,5000.00   ,13   UNION ALL	--RMB	--RMB,HK$
SELECT 3701 ,'0.4'    ,'2000'      ,0.4    ,2000.00   ,13   UNION ALL	--RMB	--RMB,HK$
SELECT 3701 ,'0.4'    ,'1000'      ,0.4    ,1000.00   ,13   UNION ALL	--RMB	--RMB,HK$
--THB
SELECT 3701 ,'4'      ,'50000'     ,4      ,50000.00  ,43   UNION ALL	--THB	--THB
SELECT 3701 ,'4'      ,'20000'     ,4      ,20000.00  ,43   UNION ALL	--THB	--THB
SELECT 3701 ,'4'      ,'10000'     ,4      ,10000.00  ,43   UNION ALL	--THB	--THB
--WON
SELECT 3701 ,'100'    ,'1250000'   ,100    ,1250000.00,45   UNION ALL	--Won	--WON
SELECT 3701 ,'100'    ,'500000'    ,100    ,500000.00 ,45   UNION ALL	--Won	--WON
SELECT 3701 ,'100'    ,'250000'    ,100    ,250000.00 ,45   UNION ALL	--Won	--WON
--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,6    UNION ALL	--EURO	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,6    UNION ALL	--EURO	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,6    UNION ALL	--EURO	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,16				--Yen	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999999


INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #StakeLevel_Temp T WITH(NOLOCK)
WHERE NOT EXISTS (SELECT TOP 1 1 FROM StakeLevel WITH(ROWLOCK)
								 WHERE t.GameTypeID = GameTypeID AND t.ExchangeId = ExchangeId  
								   AND t.MinStake = MinStake AND t.MaxStake = MaxStake )
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #StakeLevel_Temp
