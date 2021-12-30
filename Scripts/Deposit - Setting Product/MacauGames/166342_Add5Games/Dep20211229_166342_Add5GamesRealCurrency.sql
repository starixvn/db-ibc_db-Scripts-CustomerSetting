/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211229
	Created: Winfred 
	Task: #166342 - Macau Game - Add 5 new games and re-enable existing buy bonus games - Deposit [redmine : 166342]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--================= BP  ========================================
--DON, INH
SELECT 4056 ,'0.6'      ,'240'         ,0.6      ,240         ,7    UNION ALL	--DON	--DON, INH
SELECT 4062 ,'0.6'      ,'48'          ,0.6      ,48          ,7    UNION ALL	--DON	--DON, INH
SELECT 4066 ,'1.2'      ,'240'         ,1.2      ,240         ,7    UNION ALL	--DON	--DON, INH
SELECT 4076 ,'0.6'      ,'48'          ,0.6      ,48          ,7    UNION ALL	--DON	--DON, INH
SELECT 4056 ,'0.6'      ,'240'         ,0.6      ,240         ,51   UNION ALL	--INH	--DON, INH
SELECT 4062 ,'0.6'      ,'48'          ,0.6      ,48          ,51   UNION ALL	--INH	--DON, INH
SELECT 4066 ,'1.2'      ,'240'         ,1.2      ,240         ,51   UNION ALL	--INH	--DON, INH
SELECT 4076 ,'0.6'      ,'48'          ,0.6      ,48          ,51   UNION ALL	--INH	--DON, INH
--EURO
SELECT 4056 ,'0.1'      ,'5'           ,0.1      ,5           ,6    UNION ALL	--EURO	--EURO
SELECT 4062 ,'0.1'      ,'2'           ,0.1      ,2           ,6    UNION ALL	--EURO	--EURO
SELECT 4066 ,'0.2'      ,'10'          ,0.2      ,10          ,6    UNION ALL	--EURO	--EURO
SELECT 4076 ,'0.1'      ,'2'           ,0.1      ,2           ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 4056 ,'0.1'      ,'5'           ,0.1      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 4062 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4066 ,'0.2'      ,'10'          ,0.2      ,10          ,12   UNION ALL	--GBP	--GBP
SELECT 4076 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
--HK$, HID
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,92   UNION ALL	--HID	--HK$, HID
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,92   UNION ALL	--HID	--HK$, HID
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,92   UNION ALL	--HID	--HK$, HID
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,92   UNION ALL	--HID	--HK$, HID
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,5    UNION ALL	--HK$	--HK$, HID
--IN
SELECT 4056 ,'0.3'      ,'120'         ,0.3      ,120         ,15   UNION ALL	--IN	--IN
SELECT 4062 ,'0.3'      ,'24'          ,0.3      ,24          ,15   UNION ALL	--IN	--IN
SELECT 4066 ,'0.6'      ,'120'         ,0.6      ,120         ,15   UNION ALL	--IN	--IN
SELECT 4076 ,'0.3'      ,'24'          ,0.3      ,24          ,15   UNION ALL	--IN	--IN
--INR
SELECT 4056 ,'5'        ,'500'         ,5        ,500         ,61   UNION ALL	--INR	--INR
SELECT 4062 ,'5'        ,'200'         ,5        ,200         ,61   UNION ALL	--INR	--INR
SELECT 4066 ,'10'       ,'1000'        ,10       ,1000        ,61   UNION ALL	--INR	--INR
SELECT 4076 ,'5'        ,'200'         ,5        ,200         ,61   UNION ALL	--INR	--INR
--JPY
SELECT 4056 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 4062 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4066 ,'20'       ,'2000'        ,20       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 4076 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
--KHR
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--KHR
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--KHR
--MKK, MK
SELECT 4056 ,'0.1'      ,'10'          ,0.1      ,10          ,94   UNION ALL	--MK	--MKK, MK
SELECT 4062 ,'0.1'      ,'4'           ,0.1      ,4           ,94   UNION ALL	--MK	--MKK, MK
SELECT 4066 ,'0.2'      ,'20'          ,0.2      ,20          ,94   UNION ALL	--MK	--MKK, MK
SELECT 4076 ,'0.1'      ,'4'           ,0.1      ,4           ,94   UNION ALL	--MK	--MKK, MK
SELECT 4056 ,'0.1'      ,'10'          ,0.1      ,10          ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4062 ,'0.1'      ,'4'           ,0.1      ,4           ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4066 ,'0.2'      ,'20'          ,0.2      ,20          ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4076 ,'0.1'      ,'4'           ,0.1      ,4           ,70   UNION ALL	--MKK	--MKK, MK
--RM
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,2    UNION ALL	--RM	--RM
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,2    UNION ALL	--RM	--RM
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM
--RMB, YUN
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4056 ,'0.1'      ,'40'          ,0.1      ,40          ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4062 ,'0.1'      ,'8'           ,0.1      ,8           ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4066 ,'0.2'      ,'40'          ,0.2      ,40          ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4076 ,'0.1'      ,'8'           ,0.1      ,8           ,66   UNION ALL	--YUN	--RMB, YUN
--RUB
SELECT 4056 ,'5'        ,'1000'        ,5        ,1000        ,55   UNION ALL	--RUB	--RUB
SELECT 4062 ,'5'        ,'1000'        ,5        ,1000        ,55   UNION ALL	--RUB	--RUB
SELECT 4066 ,'10'       ,'1000'        ,10       ,1000        ,55   UNION ALL	--RUB	--RUB
SELECT 4076 ,'5'        ,'1000'        ,5        ,1000        ,55   UNION ALL	--RUB	--RUB
--TB
SELECT 4056 ,'1'        ,'400'         ,1        ,400         ,4    UNION ALL	--TB	--TB
SELECT 4062 ,'1'        ,'80'          ,1        ,80          ,4    UNION ALL	--TB	--TB
SELECT 4066 ,'2'        ,'400'         ,2        ,400         ,4    UNION ALL	--TB	--TB
SELECT 4076 ,'1'        ,'80'          ,1        ,80          ,4    UNION ALL	--TB	--TB
--US$, USDT, UUS
SELECT 4056 ,'0.1'      ,'10'          ,0.1      ,10          ,3    UNION ALL	--US$	--US$, USDT, UUS
SELECT 4062 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$, USDT, UUS
SELECT 4066 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--US$, USDT, UUS
SELECT 4076 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$, USDT, UUS
SELECT 4056 ,'0.1'      ,'10'          ,0.1      ,10          ,96   UNION ALL	--USDT	--US$, USDT, UUS
SELECT 4062 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$, USDT, UUS
SELECT 4066 ,'0.2'      ,'20'          ,0.2      ,20          ,96   UNION ALL	--USDT	--US$, USDT, UUS
SELECT 4076 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$, USDT, UUS
--Won
SELECT 4056 ,'100'      ,'10000'       ,100      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4062 ,'100'      ,'4000'        ,100      ,4000        ,45   UNION ALL	--Won	--Won
SELECT 4066 ,'200'      ,'20000'       ,200      ,20000       ,45   UNION ALL	--Won	--Won
SELECT 4076 ,'100'      ,'4000'        ,100      ,4000        ,45   UNION ALL	--Won	--Won
--================= VP  ========================================
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,9    UNION ALL	--AUD	--AUD
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,46   UNION ALL	--BND	--BND
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,50   UNION ALL	--CAN	--CAN
SELECT 4096 ,'2.5'      ,'25'          ,2.5      ,25          ,41   UNION ALL	--CHF	--CHF
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,52   UNION ALL	--DKK	--DKK
SELECT 4096 ,'1.5'      ,'500'         ,1.5      ,500         ,7    UNION ALL	--DON	--DON, INH
SELECT 4096 ,'1.5'      ,'500'         ,1.5      ,500         ,51   UNION ALL	--INH	--DON, INH
SELECT 4096 ,'2.5'      ,'25'          ,2.5      ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 4096 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,12   UNION ALL	--GBP	--GBP
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,92   UNION ALL	--HID	--HK$, HID
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4096 ,'0.75'     ,'250'         ,0.75     ,250         ,15   UNION ALL	--IN	--IN
SELECT 4096 ,'125'      ,'1250'        ,125      ,1250        ,61   UNION ALL	--INR	--INR
SELECT 4096 ,'250'      ,'2500'        ,250      ,2500        ,32   UNION ALL	--JPY	--JPY
SELECT 4096 ,'0.25'     ,'62.5'        ,0.25     ,62.5        ,71   UNION ALL	--KHR	--KHR
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,94   UNION ALL	--MK	--MKK, MK
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,54   UNION ALL	--NOK	--NOK
SELECT 4096 ,'6.25'     ,'62.5'        ,6.25     ,62.5        ,56   UNION ALL	--PLN	--PLN
SELECT 4096 ,'0.25'     ,'62.5'        ,0.25     ,62.5        ,2    UNION ALL	--RM	--RM
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4096 ,'0.25'     ,'62.5'        ,0.25     ,62.5        ,58   UNION ALL	--RON	--RON
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,55   UNION ALL	--RUB	--RUB
SELECT 4096 ,'0.5'      ,'125'         ,0.5      ,125         ,53   UNION ALL	--SEK	--SEK
SELECT 4096 ,'2.5'      ,'750'         ,2.5      ,750         ,4    UNION ALL	--TB	--TB
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--US$, USDT
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,96   UNION ALL	--USDT	--US$, USDT
SELECT 4096 ,'250'      ,'25000'       ,250      ,25000       ,45				--Won	--Won

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