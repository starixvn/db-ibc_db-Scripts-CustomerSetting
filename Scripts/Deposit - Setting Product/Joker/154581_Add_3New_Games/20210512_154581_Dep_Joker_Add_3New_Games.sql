/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210512
	Task:  Add 3 New Games for Joker - deposit RedmineID:#154581
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EURO
--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--INR
SELECT 6413 ,'25000','500000'  ,25000,500000  ,61   UNION ALL	--INR	--INR
SELECT 6414 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6415 ,'2000' ,'40000'   ,2000 ,40000   ,61   UNION ALL	--INR	--INR
--RM,HK$,HKK
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6415 ,'20'   ,'200'     ,20   ,200     ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6415 ,'20'   ,'200'     ,20   ,200     ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB,YUN
SELECT 6413 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6414 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6415 ,'20'   ,'2000'    ,20   ,2000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6413 ,'25'   ,'5000'    ,25   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6414 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6415 ,'20'   ,'2000'    ,20   ,2000    ,66   UNION ALL	--YUN	--RMB,YUN
--TB,THB
SELECT 6413 ,'250'  ,'7500'    ,250  ,7500    ,4    UNION ALL	--TB	--TB,THB
SELECT 6414 ,'100'  ,'20000'   ,100  ,20000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6415 ,'200'  ,'20000'   ,200  ,20000   ,4    UNION ALL	--TB	--TB,THB
--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--Won
SELECT 6413 ,'250'  ,'7500'    ,250  ,7500    ,45   UNION ALL	--Won	--Won
SELECT 6414 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6415 ,'200'  ,'6000'    ,200  ,6000    ,45				--Won	--Won

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
WHERE s.GameTypeID = 6401)

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
