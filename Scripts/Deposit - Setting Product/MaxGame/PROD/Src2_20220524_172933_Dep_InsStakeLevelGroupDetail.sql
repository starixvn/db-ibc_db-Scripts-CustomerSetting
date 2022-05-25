/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220524
	Task:  Insert Setting StakeLevelGroupDetail [MaxGame]currency real - deposit RedmineID:#172933
	DB: DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevelGroupDetail
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(37))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 5401 ,'1'      ,'1000'       ,1       ,1000       ,46   UNION ALL	--BND	--BND
SELECT 5401 ,'2'      ,'20000'      ,2       ,20000      ,15   UNION ALL	--IN	--DDD, IDD, IDR, IN, IND
SELECT 5401 ,'1'      ,'1000'       ,1       ,1000       ,12   UNION ALL	--GBP	--GBP
SELECT 5401 ,'2'      ,'50000'      ,2       ,50000      ,51   UNION ALL	--INH	--INH
SELECT 5401 ,'50'     ,'50000'      ,50      ,50000      ,61   UNION ALL	--INR	--INR
SELECT 5401 ,'1'      ,'5000'       ,1       ,5000       ,56   UNION ALL	--PLN	--PLN
SELECT 5401 ,'1'      ,'5000'       ,1       ,5000       ,2    UNION ALL	--RM	--RM
SELECT 5401 ,'2'      ,'10000'      ,2       ,10000      ,13   UNION ALL	--RMB	--RMB
SELECT 5401 ,'10'     ,'50000'      ,10      ,50000      ,4    UNION ALL	--TB	--TB, THB
SELECT 5401 ,'1'      ,'2000'       ,1       ,2000       ,3    UNION ALL	--US$	--US$, USDT, UT, YEN
SELECT 5401 ,'1'      ,'2000'       ,1       ,2000       ,96   UNION ALL	--USDT	--US$, USDT, UT, YEN
SELECT 5401 ,'1000'   ,'1000000'    ,1000    ,1000000    ,45   				--Won	--WON

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 5401)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 