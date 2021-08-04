/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210719
	Created: Winfred 
	Task: #158479 - Macau Game - Add 5 new VP and BP games May 2021 - Deposit - UUS [redmine : 158479]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #Dep_StakeLevel ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(3))
								
INSERT INTO #Dep_StakeLevel(GameTypeID,ExchangeId)
SELECT 4001,7      UNION ALL     -- DON
SELECT 4001,92     UNION ALL     -- HID
SELECT 4001,94     UNION ALL     -- MK
SELECT 4001,96					 -- USDT

DELETE a
FROM #Dep_StakeLevel a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 4001

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel a

DROP TABLE #Dep_StakeLevel



CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))

INSERT INTO #StakeLevel_Temp (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
-- 130644 =======================================================================================
SELECT 4051,92,'0.4','16',0.4,16 UNION ALL	
SELECT 4052,92,'0.4','16',0.4,16 UNION ALL	
SELECT 4053,92,'0.2','16',0.2,16 UNION ALL	
SELECT 4054,92,'0.2','16',0.2,16 UNION ALL	
SELECT 4055,92,'0.2','80',0.2,80		
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
-- 139920 =======================================================================================
--HID
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,92   UNION ALL	--HID	--HK$, HID
--153850 =======================================================================================
--DON
SELECT 4081 ,'1.8'  ,'1200'    ,1.8  ,1200    ,7    UNION ALL	--DON	--DON, INH
SELECT 4082 ,'3'    ,'1000'    ,3    ,1000    ,7    UNION ALL	--DON	--DON, INH
SELECT 4083 ,'3'    ,'1000'    ,3    ,1000    ,7    UNION ALL	--DON	--DON, INH
SELECT 4084 ,'2.4'  ,'720'     ,2.4  ,720     ,7    UNION ALL	--DON	--DON, INH
SELECT 4085 ,'1.5'  ,'1000'    ,1.5  ,1000    ,7    UNION ALL	--DON	--DON, INH
--HID
SELECT 4081 ,'0.6'  ,'300'     ,0.6  ,300     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4082 ,'1'    ,'250'     ,1    ,250     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4083 ,'1'    ,'250'     ,1    ,250     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4084 ,'0.8'  ,'240'     ,0.8  ,240     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4085 ,'0.5'  ,'250'     ,0.5  ,250     ,92   UNION ALL	--HID	--HK$, HID
--MK
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,94   UNION ALL	--MK	--MKK, MK
--USDT
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$, USDT,UUS
--=======================================================================================
--BND
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,46   UNION ALL	--BND	--BND
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,46   UNION ALL	--BND	--BND
--INR
SELECT 4086 ,'125'  ,'1250'    ,125  ,1250    ,61   UNION ALL	--INR	--INR
SELECT 4087 ,'250'  ,'2500'    ,250  ,2500    ,61   UNION ALL	--INR	--INR
SELECT 4088 ,'5'    ,'200'     ,5    ,200     ,61   UNION ALL	--INR	--INR
SELECT 4089 ,'5'    ,'200'     ,5    ,200     ,61   UNION ALL	--INR	--INR
SELECT 4090 ,'5'    ,'500'     ,5    ,500     ,61   UNION ALL	--INR	--INR
--JPY
SELECT 4086 ,'250'  ,'2500'    ,250  ,2500    ,32   UNION ALL	--JPY	--JPY
SELECT 4087 ,'500'  ,'5000'    ,500  ,5000    ,32   UNION ALL	--JPY	--JPY
SELECT 4088 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY
SELECT 4089 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY
SELECT 4090 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
--PLN
SELECT 4086 ,'6.25' ,'62.5'    ,6.25 ,62.5    ,56   UNION ALL	--PLN	--PLN
SELECT 4087 ,'12.5' ,'125'     ,12.5 ,125     ,56   UNION ALL	--PLN	--PLN
--RUB
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,55   UNION ALL	--RUB	--RUB
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,55   UNION ALL	--RUB	--RUB
SELECT 4088 ,'5'    ,'500'     ,5    ,500     ,55   UNION ALL	--RUB	--RUB
SELECT 4089 ,'5'    ,'500'     ,5    ,500     ,55   UNION ALL	--RUB	--RUB
SELECT 4090 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
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
--HID
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,92   UNION ALL	--HID	--HK$, HID
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,92   UNION ALL	--HID	--HK$, HID
--HK$
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,5    UNION ALL	--HK$	--HK$, HID
--IN
SELECT 4086 ,'0.25'  ,'250'    ,0.25 ,250     ,15   UNION ALL	--IN	--IN
SELECT 4087 ,'0.5'   ,'500'    ,0.5  ,500     ,15   UNION ALL	--IN	--IN
SELECT 4088 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN
SELECT 4089 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--IN
SELECT 4090 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--IN
--KHR
SELECT 4086 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,71   UNION ALL	--KHR	--KHR
SELECT 4087 ,'0.5'  ,'125'     ,0.5  ,125     ,71   UNION ALL	--KHR	--KHR
SELECT 4088 ,'0.1'  ,'10'      ,0.1  ,10      ,71   UNION ALL	--KHR	--KHR
SELECT 4089 ,'0.1'  ,'10'      ,0.1  ,10      ,71   UNION ALL	--KHR	--KHR
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,71   UNION ALL	--KHR	--KHR
--MK
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,94   UNION ALL	--MK	--MKK, MK
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,94   UNION ALL	--MK	--MKK, MK
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,94   UNION ALL	--MK	--MKK, MK
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,94   UNION ALL	--MK	--MKK, MK
--MKK
SELECT 4086 ,'0.25' ,'25'      ,0.25 ,25      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,70   UNION ALL	--MKK	--MKK, MK
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,70   UNION ALL	--MKK	--MKK, MK
--NOK
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,54   UNION ALL	--NOK	--NOK
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,54   UNION ALL	--NOK	--NOK
--RM
SELECT 4086 ,'0.25' ,'125'     ,0.25 ,125     ,2    UNION ALL	--RM	--RM
SELECT 4087 ,'0.25' ,'125'     ,0.25 ,125     ,2    UNION ALL	--RM	--RM
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--RM
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--RM
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,2    UNION ALL	--RM	--RM
--RMB
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4087 ,'0.1'  ,'250'     ,0.1  ,250     ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--RMB, YUN
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,13   UNION ALL	--RMB	--RMB, YUN
--YUN
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4087 ,'0.1'  ,'250'     ,0.1  ,250     ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4088 ,'0.1'  ,'8'       ,0.1  ,8       ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4089 ,'0.1'  ,'8'       ,0.1  ,8       ,66   UNION ALL	--YUN	--RMB, YUN
SELECT 4090 ,'0.1'  ,'40'      ,0.1  ,40      ,66   UNION ALL	--YUN	--RMB, YUN
--RON
SELECT 4086 ,'0.25' ,'62.5'    ,0.25 ,62.5    ,58   UNION ALL	--RON	--RON
SELECT 4087 ,'0.5'  ,'125'     ,0.5  ,125     ,58   UNION ALL	--RON	--RON
--SEK
SELECT 4086 ,'0.5'  ,'125'     ,0.5  ,125     ,53   UNION ALL	--SEK	--SEK
SELECT 4087 ,'1'    ,'250'     ,1    ,250     ,53   UNION ALL	--SEK	--SEK
--TB
SELECT 4086 ,'2.5'  ,'1500'    ,2.5  ,1500    ,4    UNION ALL	--TB	--TB
SELECT 4087 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 4088 ,'1'    ,'80'      ,1    ,80      ,4    UNION ALL	--TB	--TB
SELECT 4089 ,'1'    ,'80'      ,1    ,80      ,4    UNION ALL	--TB	--TB
SELECT 4090 ,'1'    ,'400'     ,1    ,400     ,4    UNION ALL	--TB	--TB
--US$
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$, USDT
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$, USDT
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--US$, USDT,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--US$, USDT,UUS
--USDT
SELECT 4086 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 4087 ,'0.5'  ,'50'      ,0.5  ,50      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 4088 ,'0.1'  ,'4'       ,0.1  ,4       ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4089 ,'0.1'  ,'4'       ,0.1  ,4       ,96   UNION ALL	--USDT	--US$, USDT,UUS
SELECT 4090 ,'0.1'  ,'10'      ,0.1  ,10      ,96   UNION ALL	--USDT	--US$, USDT,UUS
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