/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211019
	Created: Winfred 
	Task: #163201 - Macau Game - Add 5 new games - Deposit -Real Currency [redmine : 163201]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
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
SELECT 4091 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4092 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 4093 ,'0.2'  ,'5'       ,0.2  ,5       ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4091 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4092 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4093 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
--HK$, HID
SELECT 4091 ,'0.2'  ,'8'       ,0.2  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4091 ,'0.2'  ,'8'       ,0.2  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,5    UNION ALL	--HK$	--HK$, HID
--IN
SELECT 4091 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN
SELECT 4092 ,'0.6'  ,'24'      ,0.6  ,24      ,15   UNION ALL	--IN	--IN
SELECT 4093 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--IN
--INR
SELECT 4091 ,'5'    ,'200'     ,5    ,200     ,61   UNION ALL	--INR	--INR
SELECT 4092 ,'10'   ,'200'     ,10   ,200     ,61   UNION ALL	--INR	--INR
SELECT 4093 ,'5'    ,'500'     ,5    ,500     ,61   UNION ALL	--INR	--INR
--JPY
SELECT 4091 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY
SELECT 4092 ,'20'   ,'400'     ,20   ,400     ,32   UNION ALL	--JPY	--JPY
SELECT 4093 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
--KHR
SELECT 4091 ,'0.2'  ,'10'      ,0.2  ,10      ,71   UNION ALL	--KHR	--KHR
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,71   UNION ALL	--KHR	--KHR
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,71   UNION ALL	--KHR	--KHR
--MKK, MK
SELECT 4091 ,'0.2'  ,'4'       ,0.2  ,4       ,94   UNION ALL	--MK	--MKK, MK
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,94   UNION ALL	--MK	--MKK, MK
SELECT 4093 ,'0.2'  ,'10'      ,0.2  ,10      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4091 ,'0.2'  ,'4'       ,0.2  ,4       ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4093 ,'0.2'  ,'10'      ,0.2  ,10      ,70   UNION ALL	--MKK	--MKK, MK
--RM
SELECT 4091 ,'0.2'  ,'8'       ,0.2  ,8       ,2    UNION ALL	--RM	--RM
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,2    UNION ALL	--RM	--RM
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,2    UNION ALL	--RM	--RM
--RMB, YUN
SELECT 4091 ,'0.2'  ,'8'       ,0.2  ,8       ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4091 ,'0.2'  ,'8'       ,0.2  ,8       ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4092 ,'0.2'  ,'8'       ,0.2  ,8       ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4093 ,'0.2'  ,'40'      ,0.2  ,40      ,66   UNION ALL	--YUN	--RMB, YUN
--RUB
SELECT 4091 ,'5'    ,'500'     ,5    ,500     ,55   UNION ALL	--RUB	--RUB
SELECT 4092 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4093 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
--TB
SELECT 4091 ,'1'    ,'80'      ,1    ,80      ,4    UNION ALL	--TB	--TB
SELECT 4092 ,'2'    ,'80'      ,2    ,80      ,4    UNION ALL	--TB	--TB
SELECT 4093 ,'1'    ,'400'     ,1    ,400     ,4    UNION ALL	--TB	--TB
--US$, USDT,UUS
SELECT 4091 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4093 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4091 ,'0.2'  ,'4'       ,0.2  ,4       ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4093 ,'0.2'  ,'10'      ,0.2  ,10      ,96   UNION ALL	--USDT	--US$, USDT,UUS
--Won
SELECT 4091 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4092 ,'200'  ,'4000'    ,200  ,4000    ,45   UNION ALL	--Won	--Won
SELECT 4093 ,'100'  ,'10000'   ,100  ,10000   ,45   UNION ALL	--Won	--Won
--================  VP    ================
--AUD
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,9    UNION ALL	--AUD	--AUD
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,9    UNION ALL	--AUD	--AUD
--BND
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,46   UNION ALL	--BND	--BND
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,46   UNION ALL	--BND	--BND
--CAN
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,50   UNION ALL	--CAN	--CAN
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,50   UNION ALL	--CAN	--CAN
--CHF
SELECT 4094 ,'2.5'  ,'25'      ,2.5  ,25      ,41   UNION ALL	--CHF	--CHF
SELECT 4095 ,'1'    ,'4'       ,1    ,4       ,41   UNION ALL	--CHF	--CHF
--DKK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,52   UNION ALL	--DKK	--DKK
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,52   UNION ALL	--DKK	--DKK
--DON, INH
SELECT 4094 ,'1.5'  ,'500'     ,1.5  ,500     ,7    UNION ALL	--DON	--DON, INH
SELECT 4095 ,'0.5'  ,'80'      ,0.5  ,80      ,7    UNION ALL	--DON	--DON, INH
SELECT 4094 ,'1.5'  ,'500'     ,1.5  ,500     ,51   UNION ALL	--INH	--DON, INH
SELECT 4095 ,'0.5'  ,'80'      ,0.5  ,80      ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4094 ,'2.5'  ,'25'      ,2.5  ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 4095 ,'1'    ,'4'       ,1    ,4       ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4094 ,'1.25' ,'12.5'    ,1.25 ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4095 ,'0.5'  ,'2'       ,0.5  ,2       ,12   UNION ALL	--GBP	--GBP
--HK$, HID
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4095 ,'0.5'  ,'15'      ,0.5  ,15      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4095 ,'0.5'  ,'15'      ,0.5  ,15      ,5    UNION ALL	--HK$	--HK$, HID
--IN
SELECT 4094 ,'0.75' ,'250'     ,0.75 ,250     ,15   UNION ALL	--IN	--IN
SELECT 4095 ,'0.5'  ,'40'      ,0.5  ,40      ,15   UNION ALL	--IN	--IN
--INR
SELECT 4094 ,'125'  ,'1250'    ,125  ,1250    ,61   UNION ALL	--INR	--INR
SELECT 4095 ,'50'   ,'200'     ,50   ,200     ,61   UNION ALL	--INR	--INR
--JPY
SELECT 4094 ,'250'  ,'2500'    ,250  ,2500    ,32   UNION ALL	--JPY	--JPY
SELECT 4095 ,'100'  ,'400'     ,100  ,400     ,32   UNION ALL	--JPY	--JPY
--KHR
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,71   UNION ALL	--KHR	--KHR
SELECT 4095 ,'0.5'  ,'10'      ,0.5  ,10      ,71   UNION ALL	--KHR	--KHR
--MKK, MK
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,94   UNION ALL	--MK	--MKK, MK
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,70   UNION ALL	--MKK	--MKK, MK
--NOK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,54   UNION ALL	--NOK	--NOK
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,54   UNION ALL	--NOK	--NOK
--PLN
SELECT 4094 ,'6.25' ,'62.5'    ,6.25 ,62.5    ,56   UNION ALL	--PLN	--PLN
SELECT 4095 ,'2.5'  ,'10'      ,2.5  ,10      ,56   UNION ALL	--PLN	--PLN
--RM
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,2    UNION ALL	--RM	--RM
SELECT 4095 ,'0.5'  ,'15'      ,0.5  ,15      ,2    UNION ALL	--RM	--RM
--RMB, YUN
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,66   UNION ALL	--YUN	--RMB, YUN
--RON
SELECT 4094 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,58   UNION ALL	--RON	--RON
SELECT 4095 ,'0.5'  ,'10'      ,0.5  ,10      ,58   UNION ALL	--RON	--RON
--RUB
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,55   UNION ALL	--RUB	--RUB
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,55   UNION ALL	--RUB	--RUB
--SEK
SELECT 4094 ,'0.5'  ,'125'     ,0.5  ,125     ,53   UNION ALL	--SEK	--SEK
SELECT 4095 ,'0.5'  ,'20'      ,0.5  ,20      ,53   UNION ALL	--SEK	--SEK
--TB
SELECT 4094 ,'2.5'  ,'750'     ,2.5  ,750     ,4    UNION ALL	--TB	--TB
SELECT 4095 ,'1'    ,'120'     ,1    ,120     ,4    UNION ALL	--TB	--TB
--US$, USDT
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$, USDT
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,3    UNION ALL	--US$	--US$, USDT
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 4095 ,'0.5'  ,'4'       ,0.5  ,4       ,96   UNION ALL	--USDT	--US$, USDT
--Won
SELECT 4094 ,'250'  ,'25000'   ,250  ,25000   ,45   UNION ALL	--Won	--Won
SELECT 4095 ,'100'  ,'4000'    ,100  ,4000    ,45				--Won	--Won

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
WHERE s.GameTypeID = 4001)

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