/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210727
	Task:  Arcadia Gaming - Offer 1 new mini Games for other deposit real currency RedmineID:#158259
	DB: DBCust/CustDB
*/

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(10))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 1912 ,'100'  ,'50000'   ,100  ,50000   ,32   UNION ALL	--JPY	--JPY 
SELECT 1912 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB, YUN 
SELECT 1912 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB, YUN 
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,6    UNION ALL	--EURO	--EURO 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,15   UNION ALL	--IN	--IN 
SELECT 1912 ,'5'    ,'5000'    ,5    ,5000    ,7    UNION ALL	--DON	--INH , DON,UUS,YNG
SELECT 1912 ,'5'    ,'5000'    ,5    ,5000    ,51   UNION ALL	--INH	--INH , DON,UUS,YNG
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,92   UNION ALL	--HID	--RM,HK$, HID,KHR 
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,5    UNION ALL	--HK$	--RM,HK$, HID,KHR 
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,71   UNION ALL	--KHR	--RM,HK$, HID,KHR 
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,2    UNION ALL	--RM	--RM,HK$, HID,KHR 
SELECT 1912 ,'10'   ,'10000'   ,10   ,10000   ,61   UNION ALL	--INR	--TB,INR,PKR 
SELECT 1912 ,'10'   ,'10000'   ,10   ,10000   ,121  UNION ALL	--PKR	--TB,INR,PKR 
SELECT 1912 ,'10'   ,'10000'   ,10   ,10000   ,4    UNION ALL	--TB	--TB,INR,PKR 
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,41   UNION ALL	--CHF	--GBP,CHF,USDT 
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,12   UNION ALL	--GBP	--GBP,CHF,USDT 
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,96   UNION ALL	--USDT	--GBP,CHF,USDT 
SELECT 1912 ,'1000' ,'500000'  ,1000 ,500000  ,45				--Won	--Won 

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

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
WHERE s.GameTypeID = 1901)

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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 