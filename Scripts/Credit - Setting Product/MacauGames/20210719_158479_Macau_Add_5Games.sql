/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210719
	Created: Winfred 
	Task: #158479 - Macau Game - Add 5 new VP and BP games May 2021 - Credit - UUS [redmine : 158479]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(1))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--AUD
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,9    UNION ALL	--AUD	--AUD
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,9    UNION ALL	--AUD	--AUD
--CAN
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,50   UNION ALL	--CAN	--CAN
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,50   UNION ALL	--CAN	--CAN
--CHF
SELECT 4086 ,'2.5'  ,'25'      ,2.5  ,25      ,41   UNION ALL	--CHF	--CHF
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,41   UNION ALL	--CHF	--CHF
--DKK
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,52   UNION ALL	--DKK	--DKK
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,52   UNION ALL	--DKK	--DKK
--PE
SELECT 4086 ,'2.5'  ,'750'     ,2.5  ,750     ,42   UNION ALL	--PE	--PHP
SELECT 4087 ,'5'    ,'1500'    ,5    ,1500    ,42   UNION ALL	--PE	--PHP
--DON
SELECT 4086 ,'1.5'  ,'500'     ,1.5  ,500     ,7    UNION ALL	--DON	--DON, INH
SELECT 4087 ,'3'    ,'1000'    ,3    ,1000    ,7    UNION ALL	--DON	--DON, INH
SELECT 4088 ,'0.6'  ,'48'      ,0.6  ,48      ,7    UNION ALL	--DON	--DON, INH
SELECT 4089 ,'0.6'  ,'48'      ,0.6  ,48      ,7    UNION ALL	--DON	--DON, INH
SELECT 4090 ,'0.6'  ,'240'     ,0.6  ,240     ,7    UNION ALL	--DON	--DON, INH
--INH
SELECT 4086 ,'1.5'  ,'500'     ,1.5  ,500     ,51   UNION ALL	--INH	--DON, INH
SELECT 4087 ,'3'    ,'1000'    ,3    ,1000    ,51   UNION ALL	--INH	--DON, INH
SELECT 4088 ,'0.6'  ,'48'      ,0.6  ,48      ,51   UNION ALL	--INH	--DON, INH
SELECT 4089 ,'0.6'  ,'48'      ,0.6  ,48      ,51   UNION ALL	--INH	--DON, INH
SELECT 4090 ,'0.6'  ,'240'     ,0.6  ,240     ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4086 ,'2.5'  ,'25'      ,2.5  ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 4087 ,'5'    ,'50'      ,5    ,50      ,6    UNION ALL	--EURO	--EURO
SELECT 4088 ,'0.1'  ,'2'       ,0.1  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4089 ,'0.1'  ,'2'       ,0.1  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4090 ,'0.1'  ,'5'       ,0.1  ,5       ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4086 ,'1.25' ,'12.5'    ,1.25 ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4087 ,'2.5'  ,'25'      ,2.5  ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4088 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4089 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4090 ,'0.1'  ,'5'       ,0.1  ,5       ,12   UNION ALL	--GBP	--GBP
--HK$
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,5    UNION ALL	--HK$	--HK$
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,5    UNION ALL	--HK$	--HK$
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,5    UNION ALL	--HK$	--HK$
--DDD
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
--IDD
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
--IDR
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
--IN
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
--IND
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
--MMK
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,69   UNION ALL	--MMK	--MMK
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,69   UNION ALL	--MMK	--MMK
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,69   UNION ALL	--MMK	--MMK
--NOK
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,54   UNION ALL	--NOK	--NOK
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,54   UNION ALL	--NOK	--NOK
--HKK
SELECT 4086 ,'0.25' ,'125'     ,0.25 ,125     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4087 ,'0.25' ,'125'     ,0.25 ,125     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,67   UNION ALL	--HKK	--RM,HKK
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,67   UNION ALL	--HKK	--RM,HKK
--RM
SELECT 4086 ,'0.25' ,'125'     ,0.25 ,125     ,2    UNION ALL	--RM	--RM,HKK
SELECT 4087 ,'0.25' ,'125'     ,0.25 ,125     ,2    UNION ALL	--RM	--RM,HKK
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--RM,HKK
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--RM,HKK
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,2    UNION ALL	--RM	--RM,HKK
--CY
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,81   UNION ALL	--CY	--RMB, CY
SELECT 4087 ,'0.1'  ,'250'     ,0.1  ,250     ,81   UNION ALL	--CY	--RMB, CY
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,81   UNION ALL	--CY	--RMB, CY
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,81   UNION ALL	--CY	--RMB, CY
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,81   UNION ALL	--CY	--RMB, CY
--RMB
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4087 ,'0.1'  ,'250'     ,0.1  ,250     ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--RMB, CY
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,13   UNION ALL	--RMB	--RMB, CY
--RON
SELECT 4086 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,58   UNION ALL	--RON	--RON
SELECT 4087 ,'0.5'  ,'125'     ,0.5  ,125     ,58   UNION ALL	--RON	--RON
--SEK
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,53   UNION ALL	--SEK	--SEK
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,53   UNION ALL	--SEK	--SEK
--THB
SELECT 4086 ,'2.5'  ,'1500'    ,2.5  ,1500    ,43   UNION ALL	--THB	--THB
SELECT 4087 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 4088 ,'1'    ,'80'      ,1    ,80      ,43   UNION ALL	--THB	--THB
SELECT 4089 ,'1'    ,'80'      ,1    ,80      ,43   UNION ALL	--THB	--THB
SELECT 4090 ,'1'    ,'400'     ,1    ,400     ,43   UNION ALL	--THB	--THB
--$US
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD 
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD 
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,UUS
--US$
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD 
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD 
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,UUS
--USD
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD 
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD 
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,UUS
--UT
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD 
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD 
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,UUS
--Yen
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD 
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD 
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,UUS
--Won
SELECT 4086 ,'250'  ,'50000'   ,250  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4087 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4088 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4089 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4090 ,'100'  ,'10000'   ,100  ,10000   ,45				--Won	--Won

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