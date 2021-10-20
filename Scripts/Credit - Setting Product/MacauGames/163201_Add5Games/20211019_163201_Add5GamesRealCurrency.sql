/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211019
	Created: Winfred 
	Task: #163201 - Macau Game - Add 5 new games - Credit [redmine : 163201]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(1))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--================  BP    ================
--DON, INH
SELECT 4091 ,'0.6'  ,'48'      ,0.6  ,48      ,7    UNION ALL	--DON	--DON, INH
SELECT 4092 ,'1.2'  ,'48'      ,1.2  ,48      ,7    UNION ALL	--DON	--DON, INH
SELECT 4093 ,'0.6'  ,'240'     ,0.6  ,240     ,7    UNION ALL	--DON	--DON, INH
SELECT 4091 ,'0.6'  ,'48'      ,0.6  ,48      ,51   UNION ALL	--INH	--DON, INH
SELECT 4092 ,'1.2'  ,'48'      ,1.2  ,48      ,51   UNION ALL	--INH	--DON, INH
SELECT 4093 ,'0.6'  ,'240'     ,0.6  ,240     ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4091 ,'0.1'  ,'2'       ,0.1  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4092 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4093 ,'0.1'  ,'5'       ,0.1  ,5       ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4091 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4092 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4093 ,'0.1'  ,'5'       ,0.1  ,5       ,12   UNION ALL	--GBP	--GBP
--HK$
SELECT 4091 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,5    UNION ALL	--HK$	--HK$
SELECT 4093 ,'0.1'  ,'40'      ,0.1  ,40      ,5    UNION ALL	--HK$	--HK$
--IN,IND,IDD,IDR,DDD
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
--MMK
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,69   UNION ALL	--MMK	--MMK
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,69   UNION ALL	--MMK	--MMK
--RM,HKK
SELECT 4091 ,'0.1'  ,'8'       ,0.1  ,8       ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4093 ,'0.1'  ,'40'      ,0.1  ,40      ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4091 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--RM,HKK
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,2    UNION ALL	--RM	--RM,HKK
SELECT 4093 ,'0.1'  ,'40'      ,0.1  ,40      ,2    UNION ALL	--RM	--RM,HKK
--RMB, CY
SELECT 4091 ,'0.1'  ,'8'       ,0.1  ,8       ,81   UNION ALL	--CY	--RMB, CY
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,81   UNION ALL	--CY	--RMB, CY
SELECT 4093 ,'0.1'  ,'40'      ,0.1  ,40      ,81   UNION ALL	--CY	--RMB, CY
SELECT 4091 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4093 ,'0.1'  ,'40'      ,0.1  ,40      ,13   UNION ALL	--RMB	--RMB, CY
--THB
SELECT 4091 ,'1'    ,'80'      ,1    ,80      ,43   UNION ALL	--THB	--THB
SELECT 4092 ,'2'    ,'80'      ,2    ,80      ,43   UNION ALL	--THB	--THB
SELECT 4093 ,'1'    ,'400'     ,1    ,400     ,43   UNION ALL	--THB	--THB
--US$, Yen, $US, UT, USD,UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
--Won
SELECT 4091 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4092 ,'200'  ,'4000'    ,200  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4093 ,'100'  ,'10000'   ,100  ,10000   ,45   UNION ALL	--Won	--Won
--================  VP    ================
--AUD
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,9    UNION ALL	--AUD	--AUD
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,9    UNION ALL	--AUD	--AUD
--CAN
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,50   UNION ALL	--CAN	--CAN
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,50   UNION ALL	--CAN	--CAN
--CHF
SELECT 4094 ,'2.5'  ,'25'      ,2.5  ,25      ,41   UNION ALL	--CHF	--CHF
SELECT 4095 ,'1'    ,'4'       ,1    ,4       ,41   UNION ALL	--CHF	--CHF
--DKK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,52   UNION ALL	--DKK	--DKK
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,52   UNION ALL	--DKK	--DKK
--DON, INH
SELECT 4094 ,'1.5'  ,'500'     ,1.5  ,500     ,7    UNION ALL	--DON	--DON, INH
SELECT 4095 ,'0.6'  ,'80'      ,0.6  ,80      ,7    UNION ALL	--DON	--DON, INH
SELECT 4094 ,'1.5'  ,'500'     ,1.5  ,500     ,51   UNION ALL	--INH	--DON, INH
SELECT 4095 ,'0.6'  ,'80'      ,0.6  ,80      ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4094 ,'2.5'  ,'25'      ,2.5  ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 4095 ,'1'    ,'4'       ,1    ,4       ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4094 ,'1.25' ,'12.5'    ,1.25 ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4095 ,'0.5'  ,'2'       ,0.5  ,2       ,12   UNION ALL	--GBP	--GBP
--HK$
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,5    UNION ALL	--HK$	--HK$
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,5    UNION ALL	--HK$	--HK$
--IN,IND,IDD,IDR,DDD
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4095 ,'0.3'  ,'40'      ,0.3  ,40      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4095 ,'0.3'  ,'40'      ,0.3  ,40      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4095 ,'0.3'  ,'40'      ,0.3  ,40      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4095 ,'0.3'  ,'40'      ,0.3  ,40      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4095 ,'0.3'  ,'40'      ,0.3  ,40      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
--MMK
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,69   UNION ALL	--MMK	--MMK
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK
--NOK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,54   UNION ALL	--NOK	--NOK
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,54   UNION ALL	--NOK	--NOK
--RM,HKD,HKK
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,67   UNION ALL	--HKK	--RM,HKD,HKK
SELECT 4095 ,'0.1'  ,'10'      ,0.1  ,10      ,67   UNION ALL	--HKK	--RM,HKD,HKK
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,2    UNION ALL	--RM	--RM,HKD,HKK
SELECT 4095 ,'0.1'  ,'10'      ,0.1  ,10      ,2    UNION ALL	--RM	--RM,HKD,HKK
--RMB, C
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,81   UNION ALL	--CY	--RMB, CY
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,81   UNION ALL	--CY	--RMB, CY
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,13   UNION ALL	--RMB	--RMB, CY
--RON
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,58   UNION ALL	--RON	--RON
SELECT 4095 ,'0.1'  ,'10'      ,0.1  ,10      ,58   UNION ALL	--RON	--RON
--SEK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,53   UNION ALL	--SEK	--SEK
SELECT 4095 ,'0.2'  ,'20'      ,0.2  ,20      ,53   UNION ALL	--SEK	--SEK
--THB
SELECT 4094 ,'2.5'  ,'750'     ,2.5  ,750     ,43   UNION ALL	--THB	--THB
SELECT 4095 ,'1'    ,'120'     ,1    ,120     ,43   UNION ALL	--THB	--THB
--US$, Yen, $US, UT, USD 
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD 
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD 
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD 
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD 
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD 
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD 
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD 
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD 
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD 
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD 
--Won
SELECT 4094 ,'250'  ,'25000'   ,250  ,25000   ,45   UNION ALL	--Won	--Won
SELECT 4095 ,'100'  ,'4000'    ,100  ,4000    ,45				--Won	--Won


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
WHERE s.GameTypeID = 4001)

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