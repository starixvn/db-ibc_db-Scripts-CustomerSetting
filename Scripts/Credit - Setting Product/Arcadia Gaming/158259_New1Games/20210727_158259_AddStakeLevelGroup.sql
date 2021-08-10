
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210727
	Task:  Arcadia Gaming - Offer 1 new mini Games for other Credit sites RedmineID:#158259
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(9))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,6    UNION ALL	--EURO	--EURO 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD 
SELECT 1912 ,'3'    ,'4000'    ,3    ,4000    ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD 
SELECT 1912 ,'5'    ,'5000'    ,5    ,5000    ,51   UNION ALL	--INH	--INH ,UUS,YNG
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,5    UNION ALL	--HK$	--RM,HKK, HK$ 
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,67   UNION ALL	--HKK	--RM,HKK, HK$ 
SELECT 1912 ,'1'    ,'1000'    ,1    ,1000    ,2    UNION ALL	--RM	--RM,HKK, HK$ 
SELECT 1912 ,'2'    ,'1500'    ,2    ,1500    ,13   UNION ALL	--RMB	--RMB 
SELECT 1912 ,'10'   ,'10000'   ,10   ,10000   ,43   UNION ALL	--THB	--THB 
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,69   UNION ALL	--MMK	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1'    ,'500'     ,1    ,500     ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD,MMK
SELECT 1912 ,'1000' ,'500000'  ,1000 ,500000  ,45				--Won	--Won 

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MinStake > 999

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
WHERE s.GameTypeID = 1901)

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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
