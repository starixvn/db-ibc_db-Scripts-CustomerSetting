/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210409
	Task:  Insert Setting StakeLevelGroupDetail [Vgaming] - deposit RedmineID:#151583
	DB: DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevelGroupDetail
*/
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(26))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 3801 ,'1'    ,'2000'    ,1    ,2000    ,9    UNION ALL	--AUD	--BND, AUD,CAN,US$, USDT
SELECT 3801 ,'1'    ,'2000'    ,1    ,2000    ,46   UNION ALL	--BND	--BND, AUD,CAN,US$, USDT
SELECT 3801 ,'1'    ,'2000'    ,1    ,2000    ,50   UNION ALL	--CAN	--BND, AUD,CAN,US$, USDT
SELECT 3801 ,'1'    ,'2000'    ,1    ,2000    ,3    UNION ALL	--US$	--BND, AUD,CAN,US$, USDT
SELECT 3801 ,'1'    ,'2000'    ,1    ,2000    ,96   UNION ALL	--USDT	--BND, AUD,CAN,US$, USDT
SELECT 3801 ,'1'    ,'1500'    ,1    ,1500    ,41   UNION ALL	--CHF	--CHF
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,86   UNION ALL	--ARS	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,97   UNION ALL	--BDT	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,61   UNION ALL	--INR	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,32   UNION ALL	--JPY	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,79   UNION ALL	--KES	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,121  UNION ALL	--PKR	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'100'  ,'100000'  ,100  ,100000  ,55   UNION ALL	--RUB	--CLP,PKR, KES,JPY, ARS,BDT,INR,RUB
SELECT 3801 ,'1'    ,'1000'    ,1    ,1000    ,6    UNION ALL	--EURO	--EURO,GBP
SELECT 3801 ,'1'    ,'1000'    ,1    ,1000    ,12   UNION ALL	--GBP	--EURO,GBP
SELECT 3801 ,'5'    ,'2500'    ,5    ,2500    ,5    UNION ALL	--HK$	--HK$,RM,MKK,MK
SELECT 3801 ,'5'    ,'2500'    ,5    ,2500    ,94   UNION ALL	--MK	--HK$,RM,MKK,MK
SELECT 3801 ,'5'    ,'2500'    ,5    ,2500    ,70   UNION ALL	--MKK	--HK$,RM,MKK,MK
SELECT 3801 ,'5'    ,'2500'    ,5    ,2500    ,2    UNION ALL	--RM	--HK$,RM,MKK,MK
SELECT 3801 ,'10'   ,'20000'   ,10   ,20000   ,15   UNION ALL	--IN	--IN
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,82   UNION ALL	--BRL	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,52   UNION ALL	--DKK	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,80   UNION ALL	--GHS	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,92   UNION ALL	--HID	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,93   UNION ALL	--LAK	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,73   UNION ALL	--LIR	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,54   UNION ALL	--NOK	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,13   UNION ALL	--RMB	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,53   UNION ALL	--SEK	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'5'    ,'10000'   ,5    ,10000   ,66   UNION ALL	--YUN	--LAK,NOK,SEK,HID,LIR,RMB, YUN,DKK,BRL,GHS
SELECT 3801 ,'2'    ,'4000'    ,2    ,4000    ,71   UNION ALL	--KHR	--RON,KHR,PLN,PEN
SELECT 3801 ,'2'    ,'4000'    ,2    ,4000    ,85   UNION ALL	--PEN	--RON,KHR,PLN,PEN
SELECT 3801 ,'2'    ,'4000'    ,2    ,4000    ,56   UNION ALL	--PLN	--RON,KHR,PLN,PEN
SELECT 3801 ,'2'    ,'4000'    ,2    ,4000    ,58   UNION ALL	--RON	--RON,KHR,PLN,PEN
SELECT 3801 ,'10'   ,'20000'   ,10   ,20000   ,57   UNION ALL	--CZK	--TB,CZK,MXN
SELECT 3801 ,'10'   ,'20000'   ,10   ,20000   ,49   UNION ALL	--MXN	--TB,CZK,MXN
SELECT 3801 ,'10'   ,'20000'   ,10   ,20000   ,4    UNION ALL	--TB	--TB,CZK,MXN
SELECT 3801 ,'100'  ,'300000'  ,100  ,300000  ,45				--Won	--Won

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 3801)

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
DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 