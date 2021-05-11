/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210427
	Created: Winfred 
	Task: #153850 - Macau Game - Add 5 new VoidBridge games May 2021 - Deposit -Real Currency [redmine : 153850]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--BND
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,46   UNION ALL	--BND	--BND
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,46   UNION ALL	--BND	--BND
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,46   UNION ALL	--BND	--BND
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,46   UNION ALL	--BND	--BND
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,46   UNION ALL	--BND	--BND
--INR
SELECT 4081 ,'9'    ,'1800'    ,9    ,1800    ,61   UNION ALL	--INR	--INR
SELECT 4082 ,'15'   ,'2000'    ,15   ,2000    ,61   UNION ALL	--INR	--INR
SELECT 4083 ,'15'   ,'2000'    ,15   ,2000    ,61   UNION ALL	--INR	--INR
SELECT 4084 ,'12'   ,'1200'    ,12   ,1200    ,61   UNION ALL	--INR	--INR
SELECT 4085 ,'7.5'  ,'2000'    ,7.5  ,2000    ,61   UNION ALL	--INR	--INR
--JPY
SELECT 4081 ,'30'   ,'6000'    ,30   ,6000    ,32   UNION ALL	--JPY	--JPY
SELECT 4082 ,'50'   ,'5000'    ,50   ,5000    ,32   UNION ALL	--JPY	--JPY
SELECT 4083 ,'50'   ,'5000'    ,50   ,5000    ,32   UNION ALL	--JPY	--JPY
SELECT 4084 ,'40'   ,'4000'    ,40   ,4000    ,32   UNION ALL	--JPY	--JPY
SELECT 4085 ,'25'   ,'5000'    ,25   ,5000    ,32   UNION ALL	--JPY	--JPY
--KHR
SELECT 4081 ,'0.3'  ,'150'     ,0.3  ,150     ,71   UNION ALL	--KHR	--KHR
SELECT 4082 ,'0.5'  ,'125'     ,0.5  ,125     ,71   UNION ALL	--KHR	--KHR
SELECT 4083 ,'0.5'  ,'125'     ,0.5  ,125     ,71   UNION ALL	--KHR	--KHR
SELECT 4084 ,'0.4'  ,'120'     ,0.4  ,120     ,71   UNION ALL	--KHR	--KHR
SELECT 4085 ,'0.25' ,'125'     ,0.25 ,125     ,71   UNION ALL	--KHR	--KHR
--MXN
SELECT 4081 ,'1.5'  ,'750'     ,1.5  ,750     ,49   UNION ALL	--MXN	--MXN
SELECT 4082 ,'2.5'  ,'625'     ,2.5  ,625     ,49   UNION ALL	--MXN	--MXN
SELECT 4083 ,'2.5'  ,'625'     ,2.5  ,625     ,49   UNION ALL	--MXN	--MXN
SELECT 4084 ,'2'    ,'600'     ,2    ,600     ,49   UNION ALL	--MXN	--MXN
SELECT 4085 ,'1.25' ,'625'     ,1.25 ,625     ,49   UNION ALL	--MXN	--MXN
--PLN
SELECT 4081 ,'0.3'  ,'150'     ,0.3  ,150     ,56   UNION ALL	--PLN	--PLN
SELECT 4082 ,'0.5'  ,'125'     ,0.5  ,125     ,56   UNION ALL	--PLN	--PLN
SELECT 4083 ,'0.5'  ,'125'     ,0.5  ,125     ,56   UNION ALL	--PLN	--PLN
SELECT 4084 ,'0.4'  ,'120'     ,0.4  ,120     ,56   UNION ALL	--PLN	--PLN
SELECT 4085 ,'0.25' ,'125'     ,0.25 ,125     ,56   UNION ALL	--PLN	--PLN
--RUB
SELECT 4081 ,'9'    ,'1800'    ,9    ,1800    ,55   UNION ALL	--RUB	--RUB
SELECT 4082 ,'15'   ,'1500'    ,15   ,1500    ,55   UNION ALL	--RUB	--RUB
SELECT 4083 ,'15'   ,'1500'    ,15   ,1500    ,55   UNION ALL	--RUB	--RUB
SELECT 4084 ,'12'   ,'1200'    ,12   ,1200    ,55   UNION ALL	--RUB	--RUB
SELECT 4085 ,'7.5'  ,'1500'    ,7.5  ,1500    ,55   UNION ALL	--RUB	--RUB
--AUD
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,9    UNION ALL	--AUD	--AUD
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,9    UNION ALL	--AUD	--AUD
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,9    UNION ALL	--AUD	--AUD
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,9    UNION ALL	--AUD	--AUD
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,9    UNION ALL	--AUD	--AUD
--CAN
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,50   UNION ALL	--CAN	--CAN
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,50   UNION ALL	--CAN	--CAN
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,50   UNION ALL	--CAN	--CAN
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,50   UNION ALL	--CAN	--CAN
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,50   UNION ALL	--CAN	--CAN
--CHF
SELECT 4081 ,'3'    ,'60'      ,3    ,60      ,41   UNION ALL	--CHF	--CHF
SELECT 4082 ,'5'    ,'50'      ,5    ,50      ,41   UNION ALL	--CHF	--CHF
SELECT 4083 ,'5'    ,'50'      ,5    ,50      ,41   UNION ALL	--CHF	--CHF
SELECT 4084 ,'4'    ,'40'      ,4    ,40      ,41   UNION ALL	--CHF	--CHF
SELECT 4085 ,'2.5'  ,'50'      ,2.5  ,50      ,41   UNION ALL	--CHF	--CHF
--CZK
SELECT 4081 ,'1.5'  ,'750'     ,1.5  ,750     ,57   UNION ALL	--CZK	--CZK
SELECT 4082 ,'2.5'  ,'625'     ,2.5  ,625     ,57   UNION ALL	--CZK	--CZK
SELECT 4083 ,'2.5'  ,'625'     ,2.5  ,625     ,57   UNION ALL	--CZK	--CZK
SELECT 4084 ,'2'    ,'600'     ,2    ,600     ,57   UNION ALL	--CZK	--CZK
SELECT 4085 ,'1.25' ,'625'     ,1.25 ,625     ,57   UNION ALL	--CZK	--CZK
--DKK
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,52   UNION ALL	--DKK	--DKK
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,52   UNION ALL	--DKK	--DKK
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,52   UNION ALL	--DKK	--DKK
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,52   UNION ALL	--DKK	--DKK
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,52   UNION ALL	--DKK	--DKK
--DON
SELECT 4081 ,'1.8'  ,'1200'    ,1.8  ,1200    ,7    UNION ALL	--DON	--DON, INH
SELECT 4082 ,'3'    ,'1000'    ,3    ,1000    ,7    UNION ALL	--DON	--DON, INH
SELECT 4083 ,'3'    ,'1000'    ,3    ,1000    ,7    UNION ALL	--DON	--DON, INH
SELECT 4084 ,'2.4'  ,'720'     ,2.4  ,720     ,7    UNION ALL	--DON	--DON, INH
SELECT 4085 ,'1.5'  ,'1000'    ,1.5  ,1000    ,7    UNION ALL	--DON	--DON, INH
--INH
SELECT 4081 ,'1.8'  ,'1200'    ,1.8  ,1200    ,51   UNION ALL	--INH	--DON, INH
SELECT 4082 ,'3'    ,'1000'    ,3    ,1000    ,51   UNION ALL	--INH	--DON, INH
SELECT 4083 ,'3'    ,'1000'    ,3    ,1000    ,51   UNION ALL	--INH	--DON, INH
SELECT 4084 ,'2.4'  ,'720'     ,2.4  ,720     ,51   UNION ALL	--INH	--DON, INH
SELECT 4085 ,'1.5'  ,'1000'    ,1.5  ,1000    ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,6    UNION ALL	--EURO	--EURO
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--EURO
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--EURO
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,6    UNION ALL	--EURO	--EURO
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4081 ,'0.6'  ,'30'      ,0.6  ,30      ,12   UNION ALL	--GBP	--GBP
SELECT 4082 ,'0.5'  ,'25'      ,0.5  ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4083 ,'0.5'  ,'25'      ,0.5  ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,12   UNION ALL	--GBP	--GBP
SELECT 4085 ,'0.25' ,'25'      ,0.25 ,25      ,12   UNION ALL	--GBP	--GBP
--HID
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,92   UNION ALL	--HID	--HK$, HID
--HK$
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,5    UNION ALL	--HK$	--HK$, HID
--IN
SELECT 4081 ,'0.9'  ,'600'     ,0.9  ,600     ,15   UNION ALL	--IN	--IN
SELECT 4082 ,'1.5'  ,'500'     ,1.5  ,500     ,15   UNION ALL	--IN	--IN
SELECT 4083 ,'1.5'  ,'500'     ,1.5  ,500     ,15   UNION ALL	--IN	--IN
SELECT 4084 ,'1.2'  ,'360'     ,1.2  ,360     ,15   UNION ALL	--IN	--IN
SELECT 4085 ,'0.75' ,'500'     ,0.75 ,500     ,15   UNION ALL	--IN	--IN
--MK
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,94   UNION ALL	--MK	--MKK, MK
--MKK
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,70   UNION ALL	--MKK	--MKK, MK
--NOK
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,54   UNION ALL	--NOK	--NOK
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,54   UNION ALL	--NOK	--NOK
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,54   UNION ALL	--NOK	--NOK
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,54   UNION ALL	--NOK	--NOK
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,54   UNION ALL	--NOK	--NOK
--RM
SELECT 4081 ,'0.3'  ,'150'     ,0.3  ,150     ,2    UNION ALL	--RM	--RM
SELECT 4082 ,'0.5'  ,'125'     ,0.5  ,125     ,2    UNION ALL	--RM	--RM
SELECT 4083 ,'0.5'  ,'125'     ,0.5  ,125     ,2    UNION ALL	--RM	--RM
SELECT 4084 ,'0.4'  ,'120'     ,0.4  ,120     ,2    UNION ALL	--RM	--RM
SELECT 4085 ,'0.25' ,'125'     ,0.25 ,125     ,2    UNION ALL	--RM	--RM
--RMB
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,13   UNION ALL	--RMB	--RMB, YUN
--YUN
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,66   UNION ALL	--YUN	--RMB, YUN
--RON
SELECT 4081 ,'0.3'  ,'150'     ,0.3  ,150     ,58   UNION ALL	--RON	--RON
SELECT 4082 ,'0.5'  ,'125'     ,0.5  ,125     ,58   UNION ALL	--RON	--RON
SELECT 4083 ,'0.5'  ,'125'     ,0.5  ,125     ,58   UNION ALL	--RON	--RON
SELECT 4084 ,'0.4'  ,'120'     ,0.4  ,120     ,58   UNION ALL	--RON	--RON
SELECT 4085 ,'0.25' ,'125'     ,0.25 ,125     ,58   UNION ALL	--RON	--RON
--SEK
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,53   UNION ALL	--SEK	--SEK
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,53   UNION ALL	--SEK	--SEK
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,53   UNION ALL	--SEK	--SEK
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,53   UNION ALL	--SEK	--SEK
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,53   UNION ALL	--SEK	--SEK
--TB
SELECT 4081 ,'3'    ,'1800'    ,3    ,1800    ,4    UNION ALL	--TB	--TB
SELECT 4082 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 4083 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 4084 ,'4'    ,'1200'    ,4    ,1200    ,4    UNION ALL	--TB	--TB
SELECT 4085 ,'2.5'  ,'1500'    ,2.5  ,1500    ,4    UNION ALL	--TB	--TB
--US$
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$, USDT,UUS
--USDT
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
--UUS
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--US$, USDT,UUS
--Won
SELECT 4081 ,'300'  ,'60000'   ,300  ,60000   ,45   UNION ALL	--Won	--Won
SELECT 4082 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4083 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4084 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--Won
SELECT 4085 ,'250'  ,'50000'   ,250  ,50000   ,45				--Won	--Won

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