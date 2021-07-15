/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210531
	Task:	 Insert Setting StakeLevelGroupDetail [AdvantPlay Mini] - deposit RedmineID:#155133
	DB:		 DBCust/CustDB
	P/s : Step 3 Insert Setting StakeLevelGroupDetail
*/
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(30))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 7801 ,'100'  ,'5000'    ,100  ,5000    ,86   UNION ALL	--ARS	--ARS
SELECT 7801 ,'100'  ,'5000'    ,100  ,5000    ,97   UNION ALL	--BDT	--BDT
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,46   UNION ALL	--BND	--BND
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,82   UNION ALL	--BRL	--BRL
SELECT 7801 ,'1000' ,'50000'   ,1000 ,50000   ,83   UNION ALL	--CLP	--CLP
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,6    UNION ALL	--EURO	--EURO
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,12   UNION ALL	--GBP	--GBP
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,80   UNION ALL	--GHS	--GHS
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,5    UNION ALL	--HK$	--HK$
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,92   UNION ALL	--HID	--HK$
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,15   UNION ALL	--IN	--IN
SELECT 7801 ,'50'   ,'2800'    ,50   ,2800    ,51   UNION ALL	--INH	--INH
SELECT 7801 ,'50'   ,'2800'    ,50   ,2800    ,7    UNION ALL	--DON	--INH
SELECT 7801 ,'200'  ,'10000'   ,200  ,10000   ,61   UNION ALL	--INR	--INR
SELECT 7801 ,'200'  ,'15000'   ,200  ,15000   ,32   UNION ALL	--JPY	--JPY
SELECT 7801 ,'200'  ,'10000'   ,200  ,10000   ,79   UNION ALL	--KES	--KES
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,71   UNION ALL	--KHR	--KHR
SELECT 7801 ,'20'   ,'1000'    ,20   ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 7801 ,'5'    ,'150'     ,5    ,150     ,94   UNION ALL	--MK	--MK
SELECT 7801 ,'5'    ,'150'     ,5    ,150     ,70   UNION ALL	--MKK	--MKK
SELECT 7801 ,'25'   ,'1250'    ,25   ,1250    ,49   UNION ALL	--MXN	--MXN
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,85   UNION ALL	--PEN	--PEN
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,56   UNION ALL	--PLN	--PLN
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,2    UNION ALL	--RM	--RM
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,13   UNION ALL	--RMB	--RMB
SELECT 7801 ,'200'  ,'10000'   ,200  ,10000   ,55   UNION ALL	--RUB	--RUB
SELECT 7801 ,'100'  ,'5000'    ,100  ,5000    ,4    UNION ALL	--TB	--TB
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,3    UNION ALL	--US$	--US$
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,96   UNION ALL	--USDT	--USDT
SELECT 7801 ,'3000' ,'150000'  ,3000 ,150000  ,45   UNION ALL	--Won	--Won
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,66				--YUN	--YUN


UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 7801)

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