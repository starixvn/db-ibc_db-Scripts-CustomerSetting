/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210512
	Task:  Add 3 New Games for [Joker] - Credit RedmineID:#154581
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EURO
--DDD
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
--IDD
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
--IDR
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
--IN
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--IND
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--MMK
SELECT 6413 ,'250'  ,'7500'    ,250  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6414 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6415 ,'200'  ,'6000'    ,200  ,6000    ,69   UNION ALL	--MMK	--MMK
--HK$
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6415 ,'20'   ,'200'     ,20   ,200     ,5    UNION ALL	--HK$	--RM,HK$,HKK
--HKK
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6415 ,'20'   ,'200'     ,20   ,200     ,67   UNION ALL	--HKK	--RM,HK$,HKK
--RM
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6415 ,'20'   ,'200'     ,20   ,200     ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB
SELECT 6413 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6414 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6415 ,'20'   ,'2000'    ,20   ,2000    ,13   UNION ALL	--RMB	--RMB,YUN
--THB
SELECT 6413 ,'250'  ,'7500'    ,250  ,7500    ,43   UNION ALL	--THB	--TB,THB
SELECT 6414 ,'100'  ,'20000'   ,100  ,20000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6415 ,'200'  ,'20000'   ,200  ,20000   ,43   UNION ALL	--THB	--TB,THB
--$US
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
--US$
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--USD
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
--UT
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
--Yen
SELECT 6413 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6413 ,'250'  ,'7500'    ,250  ,7500    ,45   UNION ALL	--Won	--Won
SELECT 6414 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6415 ,'200'  ,'6000'    ,200  ,6000    ,45				--Won	--Won

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
WHERE s.GameTypeID = 6401)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 