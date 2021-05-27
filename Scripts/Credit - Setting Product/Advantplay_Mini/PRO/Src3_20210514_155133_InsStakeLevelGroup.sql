/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task:  Insert Setting StakeLevelGroupDetail for AdvantPlay Mini RedmineID:#155133
	DB: DBCust/CustDB
	P/s : Step 3 Insert Setting StakeLevelGroupDetail AdvantPlay
*/
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(29))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,35   UNION ALL	--$US	--$US	
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,47   UNION ALL	--DDD	--DDD	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,6    UNION ALL	--EURO	--EURO	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,12   UNION ALL	--GBP	--GBP	
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,5    UNION ALL	--HK$	--HK$	
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,67   UNION ALL	--HKK	--HKK	
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,33   UNION ALL	--IDD	--IDD	
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,34   UNION ALL	--IDR	--IDR	
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,15   UNION ALL	--IN	--IN	
SELECT 7801 ,'30'   ,'1700'    ,30   ,1700    ,22   UNION ALL	--IND	--IND	
SELECT 7801 ,'50'   ,'2800'    ,50   ,2800    ,51   UNION ALL	--INH	--INH		
SELECT 7801 ,'50'   ,'2800'    ,50   ,2800    ,7    UNION ALL	--DON	--INH
SELECT 7801 ,'5'    ,'150'     ,5    ,150     ,69   UNION ALL	--MMK	--MMK	
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,2    UNION ALL	--RM	--RM	
SELECT 7801 ,'10'   ,'500'     ,10   ,500     ,13   UNION ALL	--RMB	--RMB	
SELECT 7801 ,'100'  ,'5000'    ,100  ,5000    ,43   UNION ALL	--THB	--THB	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,3    UNION ALL	--US$	--US$	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,95   UNION ALL	--USD	--USD	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,64   UNION ALL	--UT	--UT	
SELECT 7801 ,'3000' ,'150000'  ,3000 ,150000  ,45   UNION ALL	--Won	--Won	
SELECT 7801 ,'2'    ,'100'     ,2    ,100     ,16				--Yen	--Yen	


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
WHERE s.GameTypeID = 7801)

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
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 